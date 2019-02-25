#!/bin/bash
echo 'match_all'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_all":{
            "boost":1.2
        }
    }
}'
echo 'match_none'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_none":{}
    }
}'