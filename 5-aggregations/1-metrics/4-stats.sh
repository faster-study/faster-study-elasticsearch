#!/bin/bash
#stats是一种multi-value聚合，会返回多个度量指标。包括：min、max、sum、count、avg
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "grades_stats":{
            "stats":{
                "field":"grade"
            }
        }
    }
}'
#同样可以使用script脚本、missing参数