#!/bin/bash
#对于存在routing的文档，我们可以在dest节点下的增加routing字段来设置routing的复制过程。
#可选参数有：keep（保持，这是默认的），discard（设置为null），=<some text>（设置新的路由）
curl -X PUT 'localhost:9200/test/_doc/2?routing=test&refresh' -H 'content-type:application/json' -d '{
    "message":"testRouting"
}'
curl -X POST 'localhost:9200/_reindex?pretty&refresh' -H 'content-type:application/json' -d '{
    "source":{
        "index":"test"
    },
    "dest":{
        "index":"new_test_routing",
        "routing":"=cat"
    }
}'

curl -X GET 'localhost:9200/new_test_routing/_doc/2?pretty'