#!/bin/bash
#高亮的配置参数可以指定为全局的，也可以指定为某个字段。字段级别的优先级高于全局的。
curl -X GET 'localhost:9200/test_highlighting/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "content":"天气"
        }
    },
    "highlight":{
        "fields":{
            "*":{
                "pre_tags":["<test>"],"post_tags":["</test>"]
            }
        }
    }
}'
