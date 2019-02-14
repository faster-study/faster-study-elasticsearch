#!/bin/bash
#如果在多个索引中存在相同的结果，则设置哪个索引的数据评分更高。有关boost的使用后续介绍。
curl -X GET 'localhost:9200/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "message":"1004"
        }
    },
    "indices_boost":[
        {"search_test":100},
        {"test_scroll":1}
    ]
}'