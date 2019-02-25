#!/bin/bash
#根据多个id查询
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "ids":{
            "type":"_doc",
            "values":[1,2,3]
        }
    }
}'