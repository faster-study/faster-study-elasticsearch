#!/bin/bash
#该类型可以存储经纬度数据
curl -X DELETE 'localhost:9200/test_geo_point'
curl -X PUT 'localhost:9200/test_geo_point?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties": {
                "location": {
                    "type": "geo_point"
                }
            }
        }
    }
}'

curl -X PUT 'localhost:9200/test_geo_point/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "text":"geo-pint test object",
    "location":{
        "lat":41.12,
        "lon":-71.33
    }
}'
curl -X PUT 'localhost:9200/test_geo_point/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
    "text":"geo-pint test string",
    "location":"41.12,-71.33"
}'
curl -X PUT 'localhost:9200/test_geo_point/_doc/3?pretty&refresh' -H 'content-type:application/json' -d '{
    "text":"geo-pint test geohash",
    "location":"drm3btev3e86"
}'
curl -X PUT 'localhost:9200/test_geo_point/_doc/4?pretty&refresh' -H 'content-type:application/json' -d '{
    "text":"geo-pint test array",
    "location": [-71.32,41.12]
}'

echo '在盒子范围内搜索'
curl -X GET 'localhost:9200/test_geo_point/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "geo_bounding_box":{
            "location":{
                "top_left":{
                    "lat":42,
                    "lon":-72
                },
                "bottom_right":{
                    "lat":40,
                    "lon":-74
                }
            }
        }
    }
}'