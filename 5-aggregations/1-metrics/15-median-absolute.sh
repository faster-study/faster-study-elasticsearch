#!/bin/bash
#获取中位数
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_median_absolute":{
            "median_absolute_deviation":{
                "field":"grade"
            }
        }
    }
}'
