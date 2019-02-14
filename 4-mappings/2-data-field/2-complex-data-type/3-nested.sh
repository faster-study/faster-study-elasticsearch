#!/bin/bash
curl -X DELETE 'localhost:9200/test_nested'
curl -X PUT 'localhost:9200/test_nested?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "user":{
                    "type":"nested"
                }
            }
        }
    }
}'
curl -X PUT 'localhost:9200/test_nested/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "group":"fans",
    "user":[
        {
            "name":"zhangsan",
            "age":4
        },
        {
            "name":"lisi",
            "age":5
        }
    ]
}'

curl -X GET 'localhost:9200/test_nested/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "nested":{
            "path":"user",
            "query":{
                "match":{
                    "user.name":"zhangsan"
                }
            },
            "inner_hits":{
                "highlight":{
                    "fields":{
                        "user.name":{}
                    }
                }
            }
        }
    }
}'