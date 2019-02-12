#!/bin/bash
# 可以使用wait_for_active_shards参数指定在删除操作执行前，必须有多少分片处于活动状态中。可以结合timeout参数用于控制等待时间。
curl -X DELETE 'localhost:9200/building/_doc/1?wait_for_active_shards=10&pretty&timeout=5s'