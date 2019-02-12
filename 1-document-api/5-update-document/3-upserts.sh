#!/bin/bash
#在请求体中加入upsert节点，允许文档不存在时，插入此节点下的内容作为新的文档。
curl -X POST 'localhost:9200/test/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
    "script":{
        "source":"ctx._source.counter+=params.count",
        "params":{
            "count":4
        }
    },
    "upsert":{
        "counter":1
    }
}'

# 可以在请求体中加入scripted_upsert。文档不存在时通过script脚本初始化文档。
curl -X POST 'localhost:9200/test2/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
    "scripted_upsert":true,
    "script":{
        "source":"ctx._source.counter=1"
    },
    "upsert":{}
}'

#可以在请求体中加入doc_as_upsert。文档不存在时，通过doc节点进行初始化文档。
curl -X POST 'localhost:9200/test3/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
    "doc":{
        "message":"doc as upsert"
    },
    "doc_as_upsert":true
}'