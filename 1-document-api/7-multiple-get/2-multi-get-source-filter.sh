#!/bin/bash
#可以使用source来过滤返回的字段
curl -X GET 'localhost:9200/_mget?pretty' -H 'content-type:application/json' -d '{
    "docs":[
        {
            "_index":"building",
            "_id":"1",
            "_source":{
                "include":["name"],
                "exclude":["address"]
            }
        }
    ]
}'

curl -X GET 'localhost:9200/_mget?pretty' -H 'content-type:application/json' -d '{
    "docs":[
        {
            "_index":"building",
            "_id":"1",
            "_source":["name"]
        }
    ]
}'