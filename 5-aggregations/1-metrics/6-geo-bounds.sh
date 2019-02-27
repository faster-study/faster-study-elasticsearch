#!/bin/bash
#geo bounds用于为一个字段计算包含所有点的边界框，即在所有的点中找出边界（左上、右下）。
#用于计算geo-point类型的字段
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_geo_bounds":{
            "geo_bounds":{
                "field":"location"
            }
        }
    }
}'
#geo_bounds下可加入wrap_longitude参数，该参数指定边界框是否允许与国际日期变更线重叠，默认为true