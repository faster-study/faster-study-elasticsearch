#!/bin/bash
#avg计算时，每个数据具有相等的权重。avg_weight对每个数据的权重进行控制。
#如果数据存在权重，则平均值的计算方式将会包含权重，即 所有的(数据*权重)之和/权重之和
#avg可以看做权重为1的avg_weight，也可以使用missing
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "weigh_grade_test":{
            "weighted_avg":{
                "value":{
                    "field":"grade"
                },
                "weight":{
                    "field":"weight"
                }
            }
        }
    }
}'