#!/bin/bash
curl -X DELETE 'localhost:9200/test_ignore_malformed'
curl -X PUT 'localhost:9200/test_ignore_malformed?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "test_malformed":{
                    "type":"integer",
                    "ignore_malformed":true
                }
            }
        }
    }
}'

curl -X PUT 'localhost:9200/test_ignore_malformed/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_malformed":"aaaa"
}'

curl -X GET 'localhost:9200/test_ignore_malformed/_search?pretty&q=*'