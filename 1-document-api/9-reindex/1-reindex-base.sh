#!/bin/bash
#reindex可以将源索引文档复制到目标索引中，默认使用的是internal版本号。会覆盖相同id的文档
#在source节点中可加入remote节点，从远程复制索引
curl -X POST 'localhost:9200/_reindex?pretty' -H 'content-type:application/json' -d '{
    "source":{
        "index":"test"
    },
    "dest":{
        "index":"new_test"
    }
}'
