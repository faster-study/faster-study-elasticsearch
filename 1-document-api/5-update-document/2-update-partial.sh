#!/bin/bash
# update api支持局部更新。更新过程为将提交的部分文档合并到已经存在的文档中（递归、对象内部合并、替换key/value和数组）。
# 关键词为doc，当script 与 doc 同时出现时，script 会覆盖doc
# 要完全替换现有文档，应使用index API。
curl -X POST 'localhost:9200/building/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
    "doc":{
        "name":"建筑名称"
    }
}'
# 默认情况下，update doc会自动检测提交的内容相当于源文档是否作出更改（检测空操作），如果未更改将不会执行更新操作。在返回结果中会存在result: noop
# {
#   "_index" : "building",
#   "_type" : "_doc",
#   "_id" : "1",
#   "_version" : 54,
#   "result" : "noop",
#   "_shards" : {
#     "total" : 0,
#     "successful" : 0,
#     "failed" : 0
#   }
# }
# 可以在请求体中使用detect_noop:false来关闭检测空操作.
# {
#     "doc":{

#     },
#     "detect_noop":false
# }

