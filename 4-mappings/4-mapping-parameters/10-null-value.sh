#!/bin/bash
curl -X DELETE 'localhost:9200/test_null_value'
curl -X PUT 'localhost:9200/test_null_value?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "status_code":{
                    "type":"keyword",
                    "null_value":"is null"
                }
            }
        }
    }
}'

curl -X PUT 'localhost:9200/test_null_value/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "status_code":null
}'

curl -X GET 'localhost:9200/test_null_value/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "status_code":"is null"
        }
    }
}'