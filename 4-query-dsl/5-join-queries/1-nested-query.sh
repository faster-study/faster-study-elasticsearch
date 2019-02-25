#!/bin/bash
#nested数据类型是针对数组对象类型的，允许对象型的数组可以被查询。
# curl -X PUT 'localhost:9200/join_nested_query?pretty' -H 'content-type:application/json' -d '{
#     "mappings":{
#         "_doc":{
#             "properties":{
#                 "obj1":{
#                     "type":"nested"
#                 }
#             }
#         }
#     }
# }'

# curl -X PUT 'localhost:9200/join_nested_query/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
#     "obj1":[
#         {
#             "name":"zhangsan"
#         },
#         {
#             "name":"nihao"
#         }
#     ]
# }'

# curl -X PUT 'localhost:9200/join_nested_query/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
#     "obj1":[
#         {
#             "name":"lisi"
#         },
#         {
#             "name":"nihao"
#         }
#     ]
# }'


curl -X GET 'localhost:9200/join_nested_query/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "nested":{
            "path":"obj1",
            "query":{
                "term":{
                    "obj1.name":"nihao"
                }
            }
        }
    }
}'