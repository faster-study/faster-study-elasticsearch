#!/bin/bash
# 可以一次搜索多个文档以进行删除，其实删除操作类似于search操作。
curl -X POST 'localhost:9200/building,people/_delete_by_query?pretty' -H 'content-type:application/json' -d '
{
    "query":{
        "match_all":{}
    }
}'
