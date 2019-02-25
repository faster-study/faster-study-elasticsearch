#!/bin/bash
curl -X DELETE 'localhost:9200/test_alias'
curl -X PUT 'localhost:9200/test_alias?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "distance":{
                    "type":"long"
                },
                "alias_distance":{
                    "type":"alias",
                    "path":"distance"
                }
            }
        }
    }
}'

echo '使用distance进行存储，不能使用alias_distance进行检索'
curl -X PUT 'localhost:9200/test_alias/_doc/1s?pretty&refresh' -H 'content-type:application/json' -d '{
    "distance":1000
}'

echo '使用alias_distance进行检索'
curl -X GET 'localhost:9200/test_alias/_search?pretty&q=alias_distance:1000'