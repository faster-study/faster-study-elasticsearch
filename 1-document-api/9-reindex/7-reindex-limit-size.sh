#!/bin/bash
#可以在请求体中使用size控制源索引中多少文档参与复制。并且可以使用sort控制顺序。
curl -X POST 'localhost:9200/_reindex?pretty&refresh' -H 'content-type:application/json' -d '{
    "size":"1",
    "source":{
        "index":"test",
        "sort":{"_id":"desc"}
    },
    "dest":{
        "index":"new_test_size"
    }
}'

curl -X GET 'localhost:9200/new_test_size/_search?q=*&pretty'