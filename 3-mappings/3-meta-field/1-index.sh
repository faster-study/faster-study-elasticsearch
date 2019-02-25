#!/bin/bash
#
curl -X PUT 'localhost:9200/test_index_1/_doc/1?refresh' -H 'content-type:application/json' -d '{
    "text":"document in index 1"
}'
curl -X PUT 'localhost:9200/test_index_2/_doc/1?refresh' -H 'content-type:application/json' -d '{
    "text":"document in index 2"
}'

curl -X GET 'localhost:9200/test_index_1,test_index_2/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "terms":{
            "_index":["test_index_1"]
        }
    }
}'