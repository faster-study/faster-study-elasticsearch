#!/bin/bash
echo '创建父子关系映射'
curl -X DELETE 'localhost:9200/test_parent_child'
curl -X PUT 'localhost:9200/test_parent_child' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "child_parent_test":{
                    "type":"join",
                    "relations":{
                        "father":"son"
                    }
                }
            }
        }
    }
}'

echo '插入父数据，必须与父文档在同一分片'

curl -X PUT 'localhost:9200/test_parent_child/_doc/1?refresh&pretty&routing=1' -H 'content-type:application/json' -d '{
    "text":"I am fasther",
    "child_parent_test":{
        "name":"father"
    }
}'

#或者使用： "child_parent_test":"father"
echo '插入子数据，必须与父文档在同一分片'
#需要指定父的文档id
curl -X PUT 'localhost:9200/test_parent_child/_doc/2?refresh&pretty&routing=1' -H 'content-type:application/json' -d '{
    "text":"I am son",
    "child_parent_test":{
        "name":"son",
        "parent":"1"
    }
}'

echo '搜索'
curl -X GET 'localhost:9200/test_parent_child/_search?pretty&q=*'

#可以建立多级父子关系，但是不建议使用。
#question->answer,comment. answer->vote
# curl -X PUT "localhost:9200/my_index" -H 'Content-Type: application/json' -d'
# {
#   "mappings": {
#     "_doc": {
#       "properties": {
#         "my_join_field": {
#           "type": "join",
#           "relations": {
#             "question": ["answer", "comment"],  
#             "answer": "vote" 
#           }
#         }
#       }
#     }
#   }
# }
# '


