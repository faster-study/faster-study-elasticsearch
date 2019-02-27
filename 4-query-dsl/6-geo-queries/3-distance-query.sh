#!/bin/bash
#过滤包含距离某个坐标点特定距离内的文档。
# curl -X PUT 'localhost:9200/distance-query-test?pretty' -H 'content-type:application/json' -d '{
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

# curl -X PUT 'localhost:9200/distance-query-test/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
#     "location":{
#         "lat":40.12,
#         "lon":-71.34
#     }
# }'
#默认的distance单位是米
#可以指定单位，distance:"1000km"
curl -X GET 'localhost:9200/distance-query-test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "bool":{
            "filter":{
                "geo_distance":{
                    "distance":1000000,
                    "location":{
                        "lat":40,
                        "lon":-70
                    }
                }
            }
        }
    }
}'