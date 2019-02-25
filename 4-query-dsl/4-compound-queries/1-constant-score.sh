#!/bin/bash
#此查询可对另一个查询进行包装，并简单的返回一个该filter查询结果中每个文档相等的常量分数。
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "constant_score":{
            "filter":{
                 "term":{
                    "message":"this"
                }
            },
            "boost":1.2
        }
    }
}'