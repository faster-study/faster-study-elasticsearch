#!/bin/bash
#允许使用正则表达式进行词条查询。
curl -X GET "localhost:9200/search_test/_search?pretty" -H 'Content-Type: application/json' -d'
{
    "query": {
        "regexp":{
            "message": ".*"
        }
    }
}
'
