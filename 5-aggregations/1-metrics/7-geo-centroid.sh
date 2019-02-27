#!/bin/bash
#geo_centroid用于计算geo-point类型的字段，获取所有坐标值所组成图形的中心点，也叫矩心。
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_centroid":{
            "geo_centroid":{
                "field":"location"
            }
        }
    }
}'
