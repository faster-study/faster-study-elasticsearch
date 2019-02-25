#!/bin/bash
#索引ip
curl -X DELETE 'localhost:9200/test_ip'
curl -X PUT 'localhost:9200/test_ip' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "ip_test":{
                    "type":"ip"
                }
            }
        }
    }
}'
curl -X POST 'localhost:9200/test_ip/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
    "ip_test":"192.168.1.1"
}'
curl -X GET 'localhost:9200/test_ip/_search?pretty&q=ip_test:192.168.0.0\/16'