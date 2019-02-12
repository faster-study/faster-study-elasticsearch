#!/bin/bash
#可以在请求体中加入explain来展示搜索过程的描述
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "explain":true,
    "size":2
}'