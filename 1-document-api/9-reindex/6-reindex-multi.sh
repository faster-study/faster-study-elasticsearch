#!/bin/bash
#可以在source中指定多个索引及type，复制到同一个目标文档中，但是如果两个源索引中的存在相同id的文档，则高版本会覆盖低版本文档。
curl -X POST 'localhost:9200/_reindex?pretty' -H 'content-type:application/json' -d '{
    "source":{
        "index":["test","building"]
    },
    "dest":{
        "index":"all_target",
        "type":"_doc"
    }
}'