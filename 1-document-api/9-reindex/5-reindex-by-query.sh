#!/bin/bash
#可以在source节点中增加query，根据查询条件复制部分文档到目标节点中。
curl -X POST 'localhost:9200/_reindex?pretty' -H 'content-type:application/json' -d '{
    "source":{
        "index":"test",
        "type":"_doc",
        "query":{
            "match":{
                "name":"test4"
            }
        }
    },
    "dest":{
        "index":"new_test"
    }
}'