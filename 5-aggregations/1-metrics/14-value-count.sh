#!/bin/bash
#single-value类型的聚合，获取文档数量。
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_count":{
            "value_count":{
                "field":"grade"
            }
        }
    }
}'