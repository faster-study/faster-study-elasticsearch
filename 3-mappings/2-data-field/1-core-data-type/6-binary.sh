#!/bin/bash
curl -X DELETE 'localhost:9200/test_binary'
curl -X PUT 'localhost:9200/test_binary?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "test_binary":{
                    "type":"binary"
                }
            }
        }
    }
}'

curl -X PUT 'localhost:9200/test_binary/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_binary":"U29tZSBiaW5hcnkgYmxvYg=="
}'

curl -X GET 'localhost:9200/test_binary/_search?pretty&q=*'

curl -X GET 'localhost:9200/test_binary/_field_caps?pretty&fields=test_binary'