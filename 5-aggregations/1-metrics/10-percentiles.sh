#!/bin/bash
#百分位计算是一个multi-value类型的聚合，用于计算从聚合文档中提取的数值，计算出一个或多个百分位数。
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_percentiles":{
            "percentiles":{
                "field":"grade"
            }
        }
    }
}'
# {
#   "aggregations" : {
#     "test_percentiles" : {
#       "values" : {
#         "1.0" : 10.0,
#         "5.0" : 10.0,
#         "25.0" : 23.799999237060547,
#         "50.0" : 35.14999961853027,
#         "75.0" : 50.29999923706055,
#         "95.0" : 99.9000015258789,
#         "99.0" : 99.9000015258789
#       }
#     }
#   }
# }
#如上返回的数据，意味着在我们参与计算的数据中。1%的数据数值不超过10，5%的不超过10，75%的不超过50.2999