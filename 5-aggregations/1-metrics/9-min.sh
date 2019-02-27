#!/bin/bash
#min是一个single-value聚合类型。从数据中提取数值类型的最小值。
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_min":{
            "min":{
                "field":"grade"
            }
        }
    }
}'