#!/bin/bash
echo '显示不存在于搜索条件的字段'
curl -X GET 'localhost:9200/test_highlighting/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
       "match":{
            "content":"天气"
        }
    },
    "highlight":{
         "require_field_match": false,
        "fields":{
            "message":{
               
            }
        }
    }
}'