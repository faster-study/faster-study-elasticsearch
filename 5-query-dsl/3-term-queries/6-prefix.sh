#!/bin/bash
#包含具有指定前缀的词条的文档
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "prefix":{
            "message":"th"
        }
    }
}'