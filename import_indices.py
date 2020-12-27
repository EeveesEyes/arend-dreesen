import requests, json, os
from elasticsearch import Elasticsearch
import json

directory = './jsonData/'

with open('') as json_file:
    data = json.load(json_file)
    for p in data['people']:


# Connect to the Elasticsearch server
# By default, the Elasticsearch instance will listen on port 9200

res = requests.get('http://localhost:9200')
print (res.content)
es = Elasticsearch([{'host': 'localhost', 'port': '9200'}])
# Create an index value object
# Because I want Elasticsearch to use a bog-standard integer at the unique _id for each document being loaded, I'm setting this up now outside the for loop I'm going to use to interate over the JSON files for loading into Elasticsearch

i = 1
# Iterate over each JSON file and load it into Elasticsearch
for filename in os.listdir(directory):
    if filename.endswith(".json"):
        f = open(filename)
        docket_content = f.read()
        # Send the data into es
        es.index(index='myindex', ignore=400, doc_type='docket',
        id=i, body=json.loads(docket_content))
        i = i + 1