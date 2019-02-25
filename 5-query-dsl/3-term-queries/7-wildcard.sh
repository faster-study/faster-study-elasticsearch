#!/bin/bash
#匹配与通配符表达式想匹配的文档，支持*和?,*标识任意，?表示单个，为了防止过慢，不易以通配符开头。
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "wildcard":{
            "message":"th*is"
        }
    }
}'