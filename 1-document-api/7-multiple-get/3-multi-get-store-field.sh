#!/bin/bash
#可以使用stored_fields来展示存储的字段。
curl -X GET 'localhost:9200/_mget?pretty' -H 'content-type:application/json' -d '{
    "docs":[
        {
            "_index":"building",
            "_id":"1",
            "stored_fields":["address"]
        }
    ]
}'