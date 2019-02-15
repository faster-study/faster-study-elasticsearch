#!/bin/bash
#此时text可用于聚合和排序
curl -X PUT 'localhost:9200/test_field_data/?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "message":{
                    "type":"text",
                    "fielddata":true
                }
            }
        }
    }
}'

#可以通过fielddata_frequency_filter参数限制一些条件，防止过大的数据参与聚合、排序。