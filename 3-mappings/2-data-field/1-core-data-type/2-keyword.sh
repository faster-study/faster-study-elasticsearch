#!/bin/bash
#keyword用于索引结构化内容的字段，例如电子邮件地址、手机号、主机名、状态、标签等。
#通常用于过滤、排序、聚合使用。
#keyword类型的字段只能通过确切值进行搜索。
curl -X PUT 'localhost:9200/mapping_keyword?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "tags":{
                    "type":"keyword"
                }
            }
        }
    }
}'

curl -X GET 'localhost:9200/mapping_keyword/_mapping?pretty'