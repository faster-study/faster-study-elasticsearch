#!/bin/bash
#创建mapping使用put命令，需要指定索引的名称
curl -X PUT 'localhost:9200/test_mapping?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "title":{
                    "type":"text"
                },
                "content":{
                    "type":"text"
                },
                "age":{
                    "type":"integer"
                }
            }
        }
    }
}'
echo '使用GET查看mapping'
curl -X GET 'localhost:9200/test_mapping/_mapping?pretty'
#或者可以使用_mapping端点在url中指定type
# curl -X PUT 'localhost:9200/test_mapping/_mapping/_doc?pretty' -H 'content-type:application/json' -d '{
#     "properties":{
#         "title":{
#             "type":"text"
#         },
#         "content":{
#             "type":"text"
#         },
#         "age":{
#             "type":"integer"
#         }
#     }
# }'
