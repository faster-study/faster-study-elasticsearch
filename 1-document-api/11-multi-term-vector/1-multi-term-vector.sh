#!/bin/bash
#可以使用_mtermvectors端点在一个请求中执行多个词条向量统计
curl -X POST 'localhost:9200/_mtermvectors?pretty' -H 'content-type:application/json' -d '{
    "docs":[
        {
            "_index":"test",
            "_type":"_doc",
            "_id":"1",
            "term_statistics":true
        },
        {
            "_index":"test",
            "_type":"_doc",
            "_id":"1",
            "fields":["field1"]
        }
    ]
}'