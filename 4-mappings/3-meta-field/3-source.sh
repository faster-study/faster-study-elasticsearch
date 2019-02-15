#!/bin/bash
curl -X PUT 'localhost:9200/test_source?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "_source":{
                "enabled":false
            }
        }
    }
}'

curl -X PUT 'localhost:9200/test_source/_doc/1?pretty' -H 'content-type:application/json' -d '{
    "message":"text"
}'