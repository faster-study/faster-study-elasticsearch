#!/bin/bash
echo '配置mapping'
curl -X DELETE 'localhost:9200/test_object'
curl -X PUT 'localhost:9200/test_object?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "phone":{
                    "type":"keyword"
                },
                "user":{
                    "properties":{
                        "age":{
                            "type":"integer"
                        },
                        "name":{
                            "type":"text"
                        }
                    }
                }
            }
        }
    }
}'
echo '插入数据'
curl -X PUT 'localhost:9200/test_object/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "phone":"18764050615",
    "user":{
        "name":"zhangsan",
        "age":18
    }
}'
echo '查看数据'
curl -X GET 'localhost:9200/test_object/_doc/1?pretty'
echo '搜索数据'
curl -X GET 'localhost:9200/test_object/_search?pretty&q=user.age:18'