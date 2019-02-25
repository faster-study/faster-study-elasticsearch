#!/bin/bash
#range查询某个字段是否具有特定范围内的的词条，匹配满足条件的文档。
#lucene查询的类型取决于字段的类型，查询是一个TermRangeQuery，对于number/date字段，查询是一个NumericRangeQuery。
# curl -X POST 'localhost:9200/search_test_range/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
#     "number":10
# }'
# curl -X POST 'localhost:9200/search_test_range/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
#     "number":20
# }'
echo '数值类型范围查询'
curl -X GET 'localhost:9200/search_test_range/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "range":{
            "number":{
                "gt":1,
                "lte":10
            }
        }
    }
}'