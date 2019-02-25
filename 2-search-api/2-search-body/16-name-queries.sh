#!/bin/bash
#允许使用命名查询,_name允许在结果中返回所匹配的查询。对于多条件的复杂查询的可读性有很大帮助。
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "bool":{
            "should":[
                {"match":{"message":{"query":"this","_name":"query this"}}},
                {"match":{"name":{"query":"1003","_name":"query 1003"}}}
            ]
        }
    }
}'