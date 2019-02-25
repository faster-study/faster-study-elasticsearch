#!/bin/bash
#可以通过format参数自定义日期格式。如果未指定使用strict_date_optional_time || epoch_millis类型的。
#可以在format一节参见具体的格式化选项
curl -X DELETE 'localhost:9200/test_date'
curl -X PUT 'localhost:9200/test_date?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "test_date":{
                    "type":"date",
                    "format":"yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis"
                }
            }
        }
    }
}'
curl -X PUT 'localhost:9200/test_date/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_date":"2019-01-01"
}'
curl -X PUT 'localhost:9200/test_date/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_date":"2019-01-01 00:00:00"
}'
curl -X PUT 'localhost:9200/test_date/_doc/3?pretty&refresh' -H 'content-type:application/json' -d '{
    "test_date":"1420070400001"
}'

curl -X GET 'localhost:9200/test_date/_search?pretty&q=*'