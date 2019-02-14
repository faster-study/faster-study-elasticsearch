#!/bin/bash
echo '创建mapping'
curl -X DELETE 'localhost:9200/test_boolean'
curl -X PUT 'localhost:9200/test_boolean?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "test_boolean":{
                    "type":"boolean"
                }
            }
        }
    }
}'

echo '插入数据'
curl -X PUT 'localhost:9200/test_boolean/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_boolean":true
}'
curl -X PUT 'localhost:9200/test_boolean/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_boolean":"true"
}'

echo '查看'
curl -X GET 'localhost:9200/test_boolean/_search?pretty&q=test_boolean:true'