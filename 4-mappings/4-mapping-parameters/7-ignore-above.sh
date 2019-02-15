#!/bin/bash
curl -X DELETE 'localhost:9200/test_ignore_above'
curl -X PUT 'localhost:9200/test_ignore_above?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "message":{
                    "type":"keyword",
                    "ignore_above":8
                }
            }
        }
    }
}' 

curl -X PUT 'localhost:9200/test_ignore_above/_doc/1?refresh&pretty' -H 'content-type:application/json' -d '{
    "message":"一二三四五六七八九十"
}'

echo '字段超出限制，没有被索引，无法搜索'
curl -X GET 'localhost:9200/test_ignore_above/_search?pretty&q=message:一二三四五六七八九十'