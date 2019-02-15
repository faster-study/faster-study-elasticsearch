#!/bin/bash
curl -X DELETE 'localhost:9200/test_copy_to'
curl -X PUT 'localhost:9200/test_copy_to?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "test_copy_to":{
                    "type":"keyword",
                    "copy_to":"all_name"
                },
                "all_name":{
                    "type":"text"
                }
            }
        }
    }
}'

curl -X PUT 'localhost:9200/test_copy_to/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_copy_to":"heihei"
}'
curl -X GET 'localhost:9200/test_copy_to/_search?pretty&q=all_name:hello'