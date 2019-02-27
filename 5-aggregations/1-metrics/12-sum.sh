#!/bin/bash
#一种signle-value度量聚合，用于汇总从聚合文档中提取的数值。
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_sum":{
            "sum":{
                "field":"grade"
            }
        }
    }
}'