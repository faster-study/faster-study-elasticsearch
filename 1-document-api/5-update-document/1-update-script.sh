#!/bin/bash
#更新api允许基于提供的脚本更新文档。该操作从索引中获取文档，运行脚本（使用可选的脚本语言和参数），并对结果进行索引（它允许删除或忽略操作）。
#该操作使用版本控制来确保在get和reindex期间没有发生并发更新。
#此操作仍然意味着文档的完全重新索引，它只是删除了一些网络往返，减少了get和index之间版本冲突的可能性。_source需要启用该字段才能使功能正常工作。
curl -X POST 'localhost:9200/building/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
    "script":{
        "source":"ctx._source.peopleNum += params.count",
        "lang":"painless",
        "params":{
            "count":4
        }
    }
}'

# 增加一个新的字段
curl -X POST 'localhost:9200/building/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
     "script" : "ctx._source.tags=[1,2,3]"
}'

curl -X POST 'localhost:9200/building/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
    "script":"ctx._source.new_field=\"testNew\""
}'

# 删除一个新的字段
curl -X POST 'localhost:9200/building/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
    "script":"ctx._source.remove(\"new_field\")"
}'

# 为集合添加数据
curl -X POST 'localhost:9200/building/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
    "script":"ctx._source.tags.add(4)"
}'

# 根据条件删除集合数据，注意，此处删除的是下标为0的元素
curl -X POST 'localhost:9200/building/_doc/1/_update?pretty' -H 'content-type:application/json' -d '{
    "script":"if(ctx._source.tags.contains(4)){ctx._source.tags.remove(0)}"
}'