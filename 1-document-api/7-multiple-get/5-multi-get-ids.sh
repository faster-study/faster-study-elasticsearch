#!/bin/bash
#可以指定单个索引，传递多个id
curl -X GET 'localhost:9200/building/_doc/_mget?pretty' -H 'content-type:application/json' -d '{
    "ids":[1,2]
}'