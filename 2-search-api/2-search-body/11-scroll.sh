#!/bin/bash
#为了使用滚动，初始搜索请求应该在参数中指定scroll的存活时间，告知搜索上下文。无须设置一个足够大的时间来处理所有数据，只需要处理本次请求的即可。
#scroll的初始请求会返回一个_scroll_id，在后续的滚动中需要携带此id。
#初始数据我们使用java导入10万条数据。
#格式：{"message":"this is x","num":x} x为从0递增
echo '初始化滚动,获取scroll id'
#需要指定size，为每次滚动的大小，此处我们设置为1万。方便测试，我们将scroll超时时间设置为5分钟。
echo `curl -X GET 'localhost:9200/test_scroll/_search?scroll=5m' -H 'content-type:application/json' -d '{
    "stored_fields":["_none_"],
    "size":10000,
    "query":{
        "match_all":{}
    },
    "sort":["num"]
}'` | grep -E '"(_scroll_id)":.*"took' -o

# echo '开始滚动，不需要包含index名称，在初始化中已经指定了'
# curl -X GET 'localhost:9200/_search/scroll?pretty' -H 'content-type:application/json' -d '{
#     "scroll":"1m",
#     "scroll_id":"DnF1ZXJ5VGhlbkZldGNoBQAAAAAAAAW1FkltbkZORkhCUW8yRkxFcnM5VGV1SkEAAAAAAAAFthZJbW5GTkZIQlFvMkZMRXJzOVRldUpBAAAAAAAABbcWSW1uRk5GSEJRbzJGTEVyczlUZXVKQQAAAAAAAAW4FkltbkZORkhCUW8yRkxFcnM5VGV1SkEAAAAAAAAFuRZJbW5GTkZIQlFvMkZMRXJzOVRldUpB"
# }'

# echo '删除滚动'
# curl -X DELETE 'localhost:9200/_search/scroll?pretty' -H 'content-type:application/json' -d '{
#     "scroll_id":"DnF1ZXJ5VGhlbkZldGNoBQAAAAAAAAW1FkltbkZORkhCUW8yRkxFcnM5VGV1SkEAAAAAAAAFthZJbW5GTkZIQlFvMkZMRXJzOVRldUpBAAAAAAAABbcWSW1uRk5GSEJRbzJGTEVyczlUZXVKQQAAAAAAAAW4FkltbkZORkhCUW8yRkxFcnM5VGV1SkEAAAAAAAAFuRZJbW5GTkZIQlFvMkZMRXJzOVRldUpB"
# }'

#还可以根据切片进行滚动。