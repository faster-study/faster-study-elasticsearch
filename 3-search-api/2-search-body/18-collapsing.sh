#!/bin/bash
#collapse节点允许根据某个字段折叠（去重）搜索结果，并且可以使用inner_hits展示去重所使用的源集合，并且可以通过inner_hits下的各种参数影响去重的结果。
echo '基础数据'
curl -X DELETE 'localhost:9200/collapse_test'
curl -X PUT 'localhost:9200/collapse_test?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "name":{
                    "type":"keyword"
                }
            }
        }
    }
}'
curl -X PUT 'localhost:9200/collapse_test/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "message":"collapsing test",
    "name":"key"
}'
curl -X PUT 'localhost:9200/collapse_test/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
    "message":"collapsing test2",
    "name":"key"
}'
curl -X PUT 'localhost:9200/collapse_test/_doc/3?pretty&refresh' -H 'content-type:application/json' -d '{
    "message":"collapsing test3",
    "name":"key1"
}'
echo 'collpse 搜索'
#可以通过inner_hits展示当前折叠的数据，可以设置size来只展示部分。
#可以在inner_hits中使用sort字段进行排序，排序分数最高的，展示在外层根节点。
curl -X GET 'localhost:9200/collapse_test/_search?pretty' -H 'content-type:application/json' -d '{
    "from":0,
    "size":2,
    "query":{
        "match_all":{}
    },
    "collapse":{
        "field":"name",
        "inner_hits":[{"name":"name_collapse","size":1}]
    }
}'