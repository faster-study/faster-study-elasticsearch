#!/bin/bash
# curl -X PUT 'localhost:9200/join_has_child_test?pretty' -H 'content-type:application/json' -d '{
#     "mappings":{
#         "_doc":{
#             "properties":{
#                 "child_parent_test":{
#                     "type":"join",
#                     "relations":{
#                         "parent":"child"
#                     }
#                 }
#             }
#         }
#     }
# }'

# echo '插入父文档，指定routing'
# curl -X PUT 'localhost:9200/join_has_child_test/_doc/1?pretty&refresh&routing=1' -H 'content-type:application/json' -d '{
#     "name":"I am parent",
#     "child_parent_test":"parent"
# }'

# echo '插入子文档，指定routing，保证父子在同一shards'
# curl -X PUT 'localhost:9200/join_has_child_test/_doc/2?pretty&refresh&routing=1' -H 'content-type:application/json' -d '{
#     "name":"I am child",
#     "child_parent_test":{
#         "name":"child",
#         "parent":"1"
#     }
# }'
echo '搜索子文档，使用inner_hits展示父文档内容'
curl -X GET 'localhost:9200/join_has_child_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "has_parent":{
            "parent_type":"parent",
            "query":{
                "match":{
                    "name":"parent"
                }
            },
            "inner_hits": {}
        }
    }
}'