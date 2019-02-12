#!/bin/bash
#PUT命令可以添加或更新一个json类型文档到指定的索引中，以此使其可以被搜索到。
#这个示例添加了一个索引为building，类型为building，id为1的文档。
curl -X PUT "localhost:9200/building/_doc/1?pretty" -H 'Content-Type: application/json' -d'
{
    "name" : "建筑",
    "address" : "建筑地址",
    "peopleNum" : 1000
}
'

# 执行后返回如下数据，其中_shards节点下的
# - total表示应该有多少个分片存储这个索引数据（包含主分片与副本分片）。
# - successful表示成功缓存索引数据的分片数量。
# - failed表示在副本索引上操作失败时的错误信息，0表示没有失败。（副本索引不存在时，同样会显示0，如需要一个副本，但当前只有一个es节点，无法创建副本，此时_cat/helath显示为yellow）

# {
#   "_index" : "building",
#   "_type" : "building",
#   "_id" : "1",
#   "_version" : 1,
#   "result" : "created",
#   "_shards" : {
#     "total" : 2,
#     "successful" : 1,
#     "failed" : 0
#   },
#   "_seq_no" : 0,
#   "_primary_term" : 1
# }
