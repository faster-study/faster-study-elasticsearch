#!/bin/bash
#extended-stats是一种multi-value聚合，会返回多个指标。
#extended-stats是stats聚合的扩展版本，额外添加了一些参数：
#sum_of_squares（平方和）、variance（方差）、std_deviation（标准差）、std_deviation_bounds（平均值加减两个标准差的值）
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_extended_stats":{
            "extended_stats":{
                "field":"grade"
            }
        }
    }
}'


#同样可以使用script脚本、missing参数