#!/bin/bash
#返回含有该字段的文档。
curl -X GET "localhost:9200/search_test/_search?pretty  " -H 'Content-Type: application/json' -d'
{
    "query": {
        "exists" : { "field" : "message" }
    }
}
'
#可以在bool查询中使用must_not来查询不存在该字段的文档
curl -X GET "localhost:9200/search_test/_search?pretty  " -H 'Content-Type: application/json' -d'
{
    "query": {
        "bool":{
            "must_not":{
                "exists" : { "field" : "a" }
            }
        }
        
    }
}
'