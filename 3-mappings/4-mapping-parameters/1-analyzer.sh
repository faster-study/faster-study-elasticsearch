#!/bin/bash
curl -X DELETE 'localhost:9200/test_analyzer'
curl -X PUT 'localhost:9200/test_analyzer?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "test":{
                    "type":"text",
                    "analyzer":"ik_smart"
                }
            }
        }
    }
}'

curl -X GET 'localhost:9200/test_analyzer/_analyze?pretty' -H 'content-type:application/json' -d '{
    "field":"test",
    "text":"今天的天气不错"
}'
