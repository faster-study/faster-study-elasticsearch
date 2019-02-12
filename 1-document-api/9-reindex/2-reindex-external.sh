#!/bin/bash
#可以将目标索引的version_type设置为external，此时源索引将不会覆盖目标索引的文档。会做增量更新。不存在添加，存在更新。
#此时源索引的版本，必须大于目标索引
curl -X POST 'localhost:9200/_reindex?pretty' -H 'content-type:application/json' -d '{
    "source":{
        "index":"test"
    },
    "dest":{
        "index":"new_test",
        "version_type":"external"
    }
}'