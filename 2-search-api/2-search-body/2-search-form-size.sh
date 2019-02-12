#!/bin/bash
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "from":0,
    "size":1,
    "query":{
        "match_all":{}
    }
}'