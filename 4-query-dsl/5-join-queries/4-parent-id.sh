#!/bin/bash
#根据parentId查询子文档
curl -X GET 'localhost:9200/join_has_child_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "parent_id":{
            "type":"child",
            "id":"1"
        }
    }
}'