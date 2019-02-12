#!/bin/bash
echo '设置自定义标签'
curl -X GET 'localhost:9200/test_highlighting/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "content":"天气"
        }
    },
    "highlight":{
        "pre_tags":["<color>"],
        "post_tags":["</color>"],
        "fields":{
            "content":{}
        }
    }
}'