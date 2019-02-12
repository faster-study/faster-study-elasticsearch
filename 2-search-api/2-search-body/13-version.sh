#!/bin/bash
#允许在搜索中返回版本号
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "version":true,
    "size":2
}'