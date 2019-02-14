#!/bin/bash
echo '创建mapping'
curl -X DELETE 'localhost:9200/test_range'
curl -X PUT 'localhost:9200/test_range?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "age_range":{
                    "type":"integer_range"
                },
                "time_range":{
                    "type":"date_range",
                    "format":"yyyy-MM-dd"
                },
                "ip_range":{
                    "type":"ip_range"
                }
            }
        }
    }
}'
echo '插入数据'
curl -X PUT 'localhost:9200/test_range/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "age_range":{
        "gte":10,
        "lte":20
    },
    "time_range":{
        "gt":"2019-01-01",
        "lt":"2020-02-02"
    },
    "ip_range":"192.168.0.0/16"
}'

echo '测试搜索'
curl -X GET 'localhost:9200/test_range/_search?pretty&q=age_range:11&q=time_range:2019-01-02&q=ip_range:192.168.0.1'