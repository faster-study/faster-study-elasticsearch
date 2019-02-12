#!/bin/bash
# get api 可以使用stored_fields参数指定返回存储的字段，如果未存储请求的字典，则不返回。
# curl -X DELETE 'localhost:9200/building?pretty'
# curl -X PUT 'localhost:9200/building?pretty' -H 'content-type:application/json' -d '
# {
#     "mappings":{
#         "_doc":{
#             "properties":{
#                 "name":{
#                     "type":"text",
#                     "store":"true"
#                 },
#                 "address":{
#                     "type":"text",
#                     "store":"false"
#                 },
#                 "peopleNum":{
#                     "type":"integer",
#                     "store":"false"
#                 }
#             }
#         }
#     }
# }
# '

# curl -X PUT 'localhost:9200/building/_doc/1?pretty' -H 'content-type:application/json' -d '{
#     "name":"测试建筑",
#     "address":"建筑地址",
#     "peopleNum":"1000"
# }'
curl -X GET 'localhost:9200/building/_doc/1?stored_fields=name,address&pretty'