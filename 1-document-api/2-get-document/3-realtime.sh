#!/bin/bash
# 默认情况下，get api获取的数据是实时的，不受索引刷新频率的影响。如果文档已更新但尚未刷新，则get将发出刷新请求并获得新的文档。
# 同样的会使其他文档发生变化，为了禁用实时get，可以将realtime设置为false。

curl -X GET 'localhost:9200/building/_doc?realtime=fasle&pretty'