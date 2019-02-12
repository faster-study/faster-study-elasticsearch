#!/bin/bash
#可以使用min_score参数来指定搜索结果中的最小评分
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "min_score":2,
    "size":100
}'