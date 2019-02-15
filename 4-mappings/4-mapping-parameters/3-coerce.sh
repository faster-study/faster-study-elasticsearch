#!/bin/bash
#此处使用了update mapping api ，注意，仅能更改coerce，无法更改type
curl -X PUT 'localhost:9200/test_coerce/_doc/_mapping?pretty' -H 'content-type:application/json' -d '{
    "properties":{
         "test_coerce":{
            "type":"integer",
            "coerce":false
        }
    }
}'
# coerce为false表示不支持强制转换

curl -X PUT 'localhost:9200/test_coerce/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_coerce":"1111"
}'
curl -X PUT 'localhost:9200/test_coerce/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_coerce":1.234
}'

curl -X GET 'localhost:9200/test_coerce/_search?pretty&q=*'