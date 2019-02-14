#!/bin/bash
curl -X PUT 'localhost:9200/test_array/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "tags":[1,2,3,4,5]
}'
curl -X GET 'localhost:9200/test_array/_doc/1?pretty'