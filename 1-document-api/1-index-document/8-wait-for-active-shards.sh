#!/bin/bash
# 我们可以在请求时使用wait_for_active_shards进行等待活动分片数量，并且可以使用timeout参数设置等待时间
curl -X PUT 'localhost:9200/building/_doc/2?wait_for_active_shards=6&timeout=5s&pretty' -H 'content-type:application/json' -d '
{
    "messages":"test wait for active shards"
}
'
