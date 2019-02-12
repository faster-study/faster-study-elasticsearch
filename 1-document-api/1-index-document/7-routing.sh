#!/bin/bash
# 文档通过路由来分部在不同的分片上，默认情况下，使用id字段的hash值来进行路由。
# 我们可以通过指定routing参数来控制路由过程。
curl -X PUT 'localhost:9200/building/_doc/1?routing=testRouting&pretty' -H 'content-type:application/json' -d '
{
    "message":"test routing"
}
'

# 如果当前路由到的分片已经存在此id的文档，则会覆盖。如果不在同一分片，则会存在两份相同id的文档。
# 存在两份相同id的文档时，默认会通过id获取文档，如需获取自定义路由的文档，需指定路由。:如：
# curl localhost:9200/building/building/1?routing=testRouting
# curl localhost:9200/building/building/1
