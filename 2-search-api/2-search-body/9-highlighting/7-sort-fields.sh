#!/bin/bash
echo '按顺序展示字段，fields设置为数组即可'
curl -X GET 'localhost:9200/test_highlighting/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "content":"天气"
        }
    },
    "highlight":{
        "require_field_match":false,
        "fields":[
            {"message":{}},
            {"content":{}}
        ]
    }
}'