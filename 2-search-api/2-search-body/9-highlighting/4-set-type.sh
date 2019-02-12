#!/bin/bash
echo '指定type为plain'
curl -X GET 'localhost:9200/test_highlighting/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "content":"天气"
        }
    },
    "highlight":{
        "type":"plain",
        "fields":{
            "content":{}
        }
    }
}'