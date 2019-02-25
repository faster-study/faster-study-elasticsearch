#!/bin/bash
curl -X DELETE 'localhost:9200/test_enabled'
curl -X PUT 'localhost:9200/test_enabled?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "user":{
                    "properties":{
                        "name":{
                            "type":"text"
                        },
                        "age":{
                            "type":"integer"
                        }
                    }
                }
            }
        }
    }
}'
curl -X PUT 'localhost:9200/test_enabled/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "user":{
        "name":"aaa",
        "age":12
    }
}'
curl -X PUT 'localhost:9200/test_enabled/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
    "user":{
        "name":"bbbb",
        "age":1
    }
}'
echo '无法进行搜索'
curl -X GET 'localhost:9200/test_enabled/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "user.name":"aaa"
        }
    }
}'
echo '但是可以直接获取'
curl -X GET 'localhost:9200/test_enabled/_doc/1?pretty'
