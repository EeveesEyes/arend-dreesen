#docker-compose -f stack.yml up
function waitForES() {
  set -e

  host="$1"
  shift
  cmd="$@"

  until $(curl --output /dev/null --silent --head --fail "$host"); do
    printf '.'
    sleep 1
  done

  # First wait for ES to start...
  response=$(curl $host)

  until [ "$response" = "200" ]; do
    response=$(curl --write-out %{http_code} --silent --output /dev/null "$host")
    echo >&2 "Elastic Search is unavailable - sleeping"
    sleep 1
  done

  # next wait for ES status to turn to Green
  health="$(curl -fsSL "$host/_cat/health?h=status")"
  health="$(echo "$health" | sed -r 's/^[[:space:]]+|[[:space:]]+$//g')" # trim whitespace (otherwise we'll have "green ")

  until [ "$health" = 'green' ] || [ "$health" = 'yellow' ]; do
    health="$(curl -fsSL "$host/_cat/health?h=status")"
    health="$(echo "$health" | sed -r 's/^[[:space:]]+|[[:space:]]+$//g')" # trim whitespace (otherwise we'll have "green ")
    echo >&2 "Elastic Search is unavailable - sleeping"
    sleep 1
  done

  echo >&2 "Elastic Search is up"
}

function SwapESIndices() {
  echo "swapping indices is currently not supported"
  return
  host=$1
  newName=$2
  oldName=$3
  echo "swapping indices $2 and $3"
  curl -XHEAD "$host/$2" | echo
}

function ESImport() {
  index_name=$1
  filename=$2
  if [ ! -f "$datapath$filename" ]; then
    echo "$filename does not exist, $index_name could not be imported"
    return 1
  fi
  #curl -H'Content-Type: application/json' -XPUT "http://localhost:9200/${index_name}/" --data @${datapath}gedichte.json

  # to generate ids by elastic search:
  #  jq -c '.[] | .id = ._id | del (._id) | {"index": {"_index": "poems", "_type": "_doc", "_id": .id}}, .'
  result=$(cat ${datapath}${filename} |
    jq -c '.[]  |  {"index": {"_index": "poems", "_type": "_doc", "_id": .id}}, .' |
    curl -H'Content-Type: application/json' -XPOST $host/_bulk --data-binary @-)
  # successful?
  echo "$result"
  errors=$(echo "$result" | jq -r '.errors')
  echo "errors? $errors"
  IFS=\" read __ __ __ KEY MESSAGE __ <<<"$result"
  case "$MESSAGE" in
  ":false,")
    echo "Index Import successful"
    return 0
    ;;
  ":true,")
    echo "Index Import resulted in Errors!"
    echo "$result"
    return 1
    ;;
  esac
}

host="http://localhost:9200"
container_name=elasticsearch

if [[ $(docker inspect -f '{{.State.Running}}' $container_name) = "true" ]]; then
  echo "elasticsearch is running"
else
  if [[ "$(docker images -q docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.1 2>/dev/null)" == "" ]]; then
     docker-compose -f stack.yml up --no-start
  fi
  echo "starting elasticsearch container"
  docker start elasticsearch
  waitForES $host
fi

datapath=./jsonData/
index_name=poems

#cat $datapath/indexMap.json | jq .r '.filename'
#declare -A myarray
while IFS="=" read -r key value; do
  filename=$(jq -nr '$index.filename' --argjson index "$value")
  indexname=$key
  echo "Importing $key index from $filename"
  if ! ESImport ${key}_new $filename; then
    continue
  fi
  # SwapESIndices $host "${key}_new" $key # currently not needed
done < <(jq -r "to_entries|map(\"\(.key)=\(.value)\")|.[]" $datapath/indexMap.json)
exit 0
