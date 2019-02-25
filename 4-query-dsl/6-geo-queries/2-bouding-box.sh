#!/bin/bash
#允许使用边界框基于点位置过滤命中的查询
# curl -X PUT 'localhost:9200/bounding-box?pretty' -H 'content-type:application/json' -d '{
#     "mappings":{
#         "_doc":{
#             "properties":{
#                 "location":{
#                     "type":"geo_point"
#                 }
#             }
#         }
#     }
# }'

# curl -X PUT 'localhost:9200/bounding-box/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
#     "location":{
#         "lat":40.12,
#         "lon":-71.34
#     }
# }'

curl -X GET 'localhost:9200/bounding-box/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "bool":{
            "filter":{
                "geo_bounding_box":{
                    "location":{
                        "top_left":{
                            "lat":40.73,
                            "lon": -74.1
                        },
                        "bottom_right":{
                            "lat":40.01,
                            "lon":-71.12
                        }
                    }
                }
            }
        }
    }
}'

#此处的top_left、bottom_right中所定义的经纬度，可以使用多种方式表示，如:字符串、数组、geohash等
#top_left、bottom_right也可以展开定义为：top、left、bottom、right
