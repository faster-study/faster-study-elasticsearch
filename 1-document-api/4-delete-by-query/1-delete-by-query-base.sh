#!/bin/bash
# delete by query允许我们通过条件来删除文档。可以不指定type。
# 请求发生时，会获取索引的快照，并且使用internal版本号来控制并发，注意internal版本控制不支持值为0的版本号。
# 多个搜索请求是顺序执行的，每找到一批文档进行相应的批处理请求来删除文档。如果批处理请求被拒绝，将会重试（最多10次）。达到最大次数后会造成请求中止。
# 删除操作并不会回滚，即使在删除过程中遇到错误。

# 可以在url参数中指定conflicts=proceed来使得即使出现错误，操作也不会被中止。

curl -X POST 'localhost:9200/building/_delete_by_query?pretty&conflicts=proceed' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "name":"建筑"
        }
    }
}'

#响应参数解释
# {
#   "took" : 147, //执行的时间，单位毫秒
#   "timed_out": false, // 是否超时
#   "total": 119, //成功处理的文档数
#   "deleted": 119, //成功删除的文档数
#   "batches": 1, //执行批量的次数
#   "version_conflicts": 0, //版本冲突数
#   "noops": 0, //始终为0，与查询更新、reindexAPI返回相同的结构体
#   "retries": {
#     "bulk": 0, //重试批量删除的次数
#     "search": 0 //重试搜索的次数
#   },
#   "throttled_millis": 0, //请求睡眠的毫秒数
#   "requests_per_second": -1.0, //有效执行的每秒请求数 qps
#   "throttled_until_millis": 0, //_delete_by_query始终等于0.在taskAPI时有效。
#   "failures" : [ ] //不可恢复的错误结果集。
# }