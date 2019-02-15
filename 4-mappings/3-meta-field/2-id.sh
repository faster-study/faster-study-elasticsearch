#!/bin/bash

curl -X PUT 'localhost:9200/test_id/_doc/1?pretty' -H 'content-type:application/json' -d '{
    "text":"message"
}'

curl -X GET 'localhost:9200/test_id/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "_id":"1"
        }
    }
}'