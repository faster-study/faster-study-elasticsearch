#!/bin/bash
#可以使用_source来过滤字段，仅将文档中该字段的复制过去。
#如果文档不包含该字段，同样会复制过去，但source为空
curl -X POST 'localhost:9200/_reindex?pretty&refresh' -H 'content-type:application/json' -d '{
    "source":{
        "index":"test",
        "_source":["name"]
    },
    "dest":{
        "index":"new_test_source"
    }
}'

curl -X GET 'localhost:9200/new_test_source/_search?pretty&q=*'
