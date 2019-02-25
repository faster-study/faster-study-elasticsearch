#!/bin/bash
#补全类型允许用户通过suggester api进行补全搜索
curl -X DELETE 'localhost:9200/test_completion'
curl -X PUT 'localhost:9200/test_completion?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "content":{
                    "type":"completion"
                }
            }
        }
    }
}'
curl -X PUT 'localhost:9200/test_completion/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "content":"Time is free.I found a new way to study."
}'
echo '检索'
curl -X GET 'localhost:9200/test_completion/_search?pretty' -H 'content-type:application/json' -d '{
    "suggest":{
        "completion-test":{
            "prefix":"Time",
            "completion" : {
                "field" : "content"
            }
        }
    }
}'