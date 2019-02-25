#!/bin/bash
# terms-query 筛选包含与提供的术语列表中任意一个术语匹配的文档。
echo 'terms 基本测试'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "terms":{
            "message":["1006","1007"]
        }
    }
}'
# 如要过滤你的粉丝发的推文，需要在过滤器中指定大量的用户ID，此时这样的场景，term过滤是有意义的。
# 支持的参数：index、type、id、path、routing
echo 'terms 参数测试'
curl -X PUT "localhost:9200/search_test/_doc/99999?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "term_test" : ["1005", "1001"]
}
'
curl -X GET "localhost:9200/search_test/_search?pretty" -H 'Content-Type: application/json' -d'
{
    "query" : {
        "terms" : {
            "message" : {
                "index" : "search_test",
                "type" : "_doc",
                "id":"99999",
                "path": "term_test"
            }
        }
    }
}
'
