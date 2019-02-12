#!/bin/bash
#可以在请求体中使用_source进行过滤返回字段。
echo '不返回任何字段:'
curl -X GET  'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "_source": false,
    "query":{
        "match_all":{}
    }
}'

echo '仅返回name字段'
#也可以使用include进行包含
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "_source":["name"],
    "query":{
        "match_all":{}
    }
}'

#此处也可以加入include进行包含某个属性
echo '包含location,排除values'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "_source":{
        "excludes":["values"]
    },
    "query":{
        "match_all":{}
    }
}'