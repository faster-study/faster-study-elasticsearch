#!/bin/bash
curl -X DELETE 'localhost:9200/test_percolator'
curl -X PUT 'localhost:9200/test_percolator?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "query_test":{
                    "type":"percolator"
                },
                "content":{
                    "type":"text"
                }
            }
        }
    }
}'

echo '注册查询语句'

curl -X PUT 'localhost:9200/test_percolator/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "query_test":{
        "match":{
            "content":"found hello"
        }
    }
}'

echo '基础使用'
curl -X GET 'localhost:9200/test_percolator/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "percolate":{
            "field":"query_test",
            "document":{
                "content":"hello zhang san"
            }
        }
    }
}'

#建议将percolator单独建立索引，用于存储各个查询。与数据分离。
echo '数据在其他索引，使用查询索引的查询语句进行查询'
curl -X GET 'localhost:9200/test_percolator/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "percolate":{
            "field":"query_test",
            "index":"test_completion",
            "type":"_doc",
            "id":"1"
        }
    }
}'