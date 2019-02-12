#!/bin/bash
#设置目标索引op_type为create时，如果目标索引存在任何文档，将导致索引失败。
curl -X POST 'localhost:9200/_reindex?pretty' -H 'content-type:application/json' -d '{
    "conflicts":"proceed",
    "source":{
        "index":"test"
    },
    "dest":{
        "index":"new_test",
        "op_type":"create"
    }
}'
