#!/bin/bash
# 前文介绍过使用routing索引字段，在获取时相应的需要指定routing。
curl -X PUT 'localhost:9200/building/_doc/1?routing=testRouting&pretty' -H 'content-type:application/json' -d '
{
    "message":"testRouting"
}'
curl -X GET 'localhost:9200/building/_doc/1?routing=testRouting&pretty' 