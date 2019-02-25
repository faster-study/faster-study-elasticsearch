#!/bin/bash
#模糊查询生成在模糊性中指定的最大编辑距离内的所有可能的匹配项。
curl -X GET "localhost:9200/search_test/_search?pretty" -H 'Content-Type: application/json' -d'
{
    "query": {
       "fuzzy":{ 
           "message":{
                "value": "th",
                "fuzziness": 2
           }
        }
    }
}
'
#fuzziness指定模糊的边距。 原文为this，当2时th也可以匹配到。