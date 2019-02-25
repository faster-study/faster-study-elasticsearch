#!/bin/bash
#function_score允许你修改一个查询检索文档的分数。
#你需要定义一个查询和一个或多个function。
#支持的函数:
#script_score
#weight
#random_score: 可以使用这个做一致性随机（即指定一个随机种子进行随机，种子相同的情况下每次随机结果都一样）
#field_value_factor
#decay functions:gauss, linear, exp
echo '基本用法'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "function_score":{
            "query":{
                "match":{
                    "message":"this"
                }
            },
            "random_score":{}
        }
    }
}'
echo '多个function'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "function_score":{
            "query":{
                "match_all":{}
            },
            "functions":[
                {
                    "random_score":{
                        "seed":1
                    }
                },
                {
                    "script_score" : {
                        "script" : {
                            "source": "Math.random()"
                        }
                    }
                }
            ]
        }
    }
}'

