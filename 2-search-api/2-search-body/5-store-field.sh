#!/bin/bash
#允许使用store_fields过滤在mapping中指定stored为true的字段。
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json'  -d '{
    "stored_fields":["name"],
    "query":{
        "match_all":{}
    }
}'

#可以使用_none_禁用返回存储的字段和元数据。此时_source和version也不可用。
echo '禁用stored fields和meta fields'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json'  -d '{
    "stored_fields":"_none_",
    "query":{
        "match_all":{}
    }
}'