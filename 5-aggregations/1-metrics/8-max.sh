#!/bin/bash
#single-value聚合，获取最大值
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_max":{
            "max":{
                "field":"grade"
            }
        }
    }
}'