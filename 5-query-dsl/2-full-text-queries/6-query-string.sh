#!/bin/bash
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "query_string":{
            "default_field":"message",
            "query":"this is AND 1007"
        }
    }
}'