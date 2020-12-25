import ky from "ky";
import bodybuilder from 'bodybuilder'

// const mongojs = require('mongojs')
// import config from "../config";

// we can also provide some credentials
// const db = mongojs(`${config.mongodb_user}:${config.mongodb_pw}@${process.env["VUE_APP_DATABASEURL"]}`)

export default class DataService {
    static async getPoem(title) {
        const query = bodybuilder().query('match', 'title', title).size(1).build()
        return this.performQuery('poems', query)
    }

    static async performQuery(index, query) {
        const url = `${process.env["VUE_APP_DATABASEURL"]}/${index}/_search`
        const result = await ky.post(url, {json: query}).json()
        let resultSet
        resultSet = result.hits.hits.map(hit => hit._source)
        return resultSet
    }
}
