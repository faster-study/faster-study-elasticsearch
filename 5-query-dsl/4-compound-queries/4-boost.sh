#!/bin/bash
#boosting查询可以用来有效地降级能匹配给定查询的结果。与bool查询中的not子句不同，这仍然会选择包含非预期条款的文档，但会降低其总分。
#positive用来编写正常的查询
#negative用来编写需要降级的查询条件
#negative_boost设置降级的权重
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "boosting":{
            "positive":{
                "term":{
                    "message":"this"
                }
            },
            "negative":{
              "term":{
                  "message":"1001"
              }  
            },
             "negative_boost" : 0.2
        }
    }
}'