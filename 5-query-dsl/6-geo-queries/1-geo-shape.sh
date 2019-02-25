#!/bin/bash
#geo shape 提供了两种查询的方式，一种是在当前查询中定义一个形状，一种是引用索引中的形状。

echo '定义一个形状进行查询'
# curl -X PUT 'localhost:9200/query-geo-shape' -H 'content-type:application/json' -d '{
#     "mappings":{
#         "_doc":{
#             "properties":{
#                 "location":{
#                     "type":"geo_shape"
#                 }
#             }
#         }
#     }
# }'

# curl -X POST 'localhost:9200/query-geo-shape/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
#     "name":"wind wetter",
#     "location":{
#         "type":"point",
#         "coordinates":[13.400544, 52.530286]
#     }
# }'
#如果不需要得分，建议使用bool的filter查询，filter存在高速缓存。
curl -X GET 'localhost:9200/query-geo-shape/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "geo_shape":{
            "location":{
                "shape":{
                    "type":"envelope",
                    "coordinates" : [[13.0, 53.0], [14.0, 52.0]]
                },
                "relation":"within"
            }
        }
    }
}'

# echo '引用索引中的形状'
# curl -X PUT 'localhost:9200/query-geo-shape-include?pretty' -H 'content-type:application/json' -d '{
#     "mappings":{
#         "_doc":{
#             "properties":{
#                 "location":{
#                     "type":"geo_shape"
#                 }
#             }
#         }
#     }
# }'
# curl -X PUT 'localhost:9200/query-geo-shape-include/_doc/1?pretty&refresh' -H  'content-type:application/json' -d '{
#     "location":{
#         "type":"envelope",
#         "coordinates":[[13.0,53.0],[14.0,52.0]]
#     }
# }'
curl -X GET "localhost:9200/query-geo-shape/_search?pretty" -H 'Content-Type: application/json' -d'
{
    "query": {
        "bool": {
            "filter": {
                "geo_shape": {
                    "location": {
                        "indexed_shape": {
                            "index": "query-geo-shape-include",
                            "type": "_doc",
                            "id": "1",
                            "path": "location"
                        }
                    }
                }
            }
        }
    }
}
'