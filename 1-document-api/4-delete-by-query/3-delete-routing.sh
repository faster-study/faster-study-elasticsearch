#!/bin/bash
#使用routing创建的索引，需要使用routing进行删除
curl -X POST 'localhost:9200/building/_delete_by_query?routing=testRouting&pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_all":{}
    }
}'