#!/bin/bash
#parent-join和nested功能允许返回关联的文档。在这两种类型的查询情况下，隐藏了所关联的文档内部的信息。在大部分情况下，我们都需要展示内部的信息。
#我们可以在has_child、has_parent、nested、collapse节点下加入inner_hits来展示关联文档内部的信息。
#结构如下：
# "query":{
#    "nested/has_parent/has_child":{
#       "inner_hits":{
#           <inner_hits_options>
#       }
#     }
# }
# options可选参数如下：
# from：从0开始
# size: 每页数量
# sort: 排序
# name: 响应中inner_hits节点下展示的关联文档的名称，在单个搜索请求中定义了多个关联查询有用。
# hightligt
# explain
# source filter
# script fields
# doc value fields
# include version
# echo 'nested inner hits 基础数据'
# curl -X PUT 'localhost:9200/test_inner_hits?pretty' -H 'content-type:application/json' -d '{
#     "mappings":{
#         "_doc":{
#             "properties":{
#                 "comments":{
#                     "type":"nested"
#                 }
#             }
#         }
#     }
# }' 

# curl -X PUT 'localhost:9200/test_inner_hits/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
#     "title":"test title",
#     "comments":[
#         {
#             "author":"kim",
#             "number":"1"
#         },
#         {
#             "author":"nik",
#             "number":"2"
#         }
#     ]
# }'
echo 'nested inner hits 普通搜索请求'
curl -X GET 'localhost:9200/test_inner_hits/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "nested":{
            "path":"comments",
            "query":{
                "match":{"comments.author":"nik"}
            },
            "inner_hits":{
                "name":"nested_comments"
            }
        }
    }
}'

#由于nested的文档是不存在source的，在搜索过程中会解析根文档的代码以获取source及类型，为了避免相对昂贵的性能消耗，可以禁用source，使用docvalue_field。
echo 'nested inner hits docvalue_fields搜索请求'
curl -X GET 'localhost:9200/test_inner_hits/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "nested":{
            "path":"comments",
            "query":{
                "match":{"comments.author":"nik"}
            },
            "inner_hits":{
                "_source":false,
                "docvalue_fields":[
                    {
                        "field":"comments.author.keyword",
                        "format":"use_field_mapping"
                    }
                ],
                "name":"nested_comments"
            }
        }
    }
}'


#parent/child inner hits
# curl -X DELETE 'localhost:9200/test_parent_child_inner_hits'
# echo 'parent/child inner hits 基础数据'
# curl -X PUT 'localhost:9200/test_parent_child_inner_hits?pretty' -H 'content-type:application/json' -d '{
#     "mappings":{
#         "_doc":{
#             "properties":{
#                 "teacher_student_join":{
#                     "type":"join",
#                     "relations":{
#                         "teacher":"student"
#                     }
#                 }
#             }
#         }
#     }
# }'

# curl -X PUT 'localhost:9200/test_parent_child_inner_hits/_doc/1?pretty&refresh&routing=1' -H 'content-type:application/json' -d '{
#     "message":"I am teacher 1",
#     "teacher_student_join":"teacher"
# }'

# curl -X PUT 'localhost:9200/test_parent_child_inner_hits/_doc/2?pretty&refresh&routing=1' -H 'content-type:application/json' -d '{
#     "message":"I am teacher 2",
#     "teacher_student_join":"teacher"
# }'
# curl -X PUT 'localhost:9200/test_parent_child_inner_hits/_doc/3?pretty&refresh&routing=1' -H 'content-type:application/json' -d '{
#     "text":"I am student 1",
#     "teacher_student_join":{
#         "name":"student",
#         "parent":"2"
#     }
# }'
# curl -X PUT 'localhost:9200/test_parent_child_inner_hits/_doc/4?pretty&refresh&routing=1' -H 'content-type:application/json' -d '{
#     "text":"I am student 2",
#     "teacher_student_join":{
#         "name":"student",
#         "parent":"1"
#     }
# }'
echo 'has parent inner hits 搜索'
curl -X GET 'localhost:9200/test_parent_child_inner_hits/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "has_parent":{
            "parent_type":"teacher",
            "query":{
                "match":{
                    "message":"1"
                }
            },
            "inner_hits":{}
        }
    }
}'
echo 'has child inner hits 搜索'
curl -X GET 'localhost:9200/test_parent_child_inner_hits/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "has_child":{
            "type":"student",
            "query":{
                "match":{
                    "text":"1"
                }
            },
            "inner_hits":{}
        }
    }
}'