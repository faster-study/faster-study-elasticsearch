#!/bin/bash
# multi get api 允许根据多个index、type和id获取多个文档。
# 返回一个docs数组，包含所有结果集
curl -X GET 'localhost:9200/_mget?pretty' -H 'content-type:application/json' -d '{
    "docs":[
        {
            "_index":"building",
            "_type":"_doc",
            "_id":"1"
        },
        {
            "_index":"test",
            "_type":"_doc",
            "_id":"1"
        }
    ]
}'

# {
#   "docs" : [
#     {
#       "_index" : "building",
#       "_type" : "_doc",
#       "_id" : "1",
#       "_version" : 60,
#       "found" : true,
#       "_source" : {
#         "address" : "建筑地址",
#         "name" : "建筑名称",
#         "peopleNum" : 1040,
#         "tags" : [
#           2,
#           3,
#           4
#         ]
#       }
#     },
#     {
#       "_index" : "test",
#       "_type" : "_doc",
#       "_id" : "1",
#       "_version" : 10,
#       "found" : true,
#       "_source" : {
#         "counter" : 37
#       }
#     }
#   ]
# }