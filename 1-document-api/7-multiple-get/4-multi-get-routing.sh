#!/bin/bash
#可以使用routing进行查询
curl -X GET 'localhost:9200/_mget?pretty' -H 'content-type:application/json' -d '{
    "docs":[
        {
            "_index":"building",
            "_id":"1",
            "routing":"testRouting"
        }
    ]
}'