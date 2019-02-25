#!/bin/bash
#根据类型查询
curl -X GET "localhost:9200/search_test/_search?pretty" -H 'Content-Type: application/json' -d'
{
    "query": {
        "type" : {
            "value" : "_doc"
        }
    }
}
'
