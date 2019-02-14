#!/bin/bash
#允许返回doc字段，他允许未在mapping中指定stored的字段。
#字段名称的类型同样必须为检索类型的
#可以使用format格式化返回的field
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_all":{}
    },
    "docvalue_fields":[
        {
            "field":"name",
            "format":"use_field_mapping"
        }
    ]
}'