#!/bin/bash
#script query 允许通过脚本进行查询，通常用于filter中
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "bool":{
            "filter":{
                "script":{
                    "script":{
                        "source":"doc[\"name\"].value==\"1007\""
                    }
                }
            }
        }
    }
}'