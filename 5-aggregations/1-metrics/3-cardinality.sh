#!/bin/bash
#cardinality被称为基数聚合，是一种single-value类型的聚合，其作用是：统计某个字段去重后的数量
#官方原文是approximate count of distinct values，针对于不同数据的近似数量。近似的意思在于它不是完全100%精确的。
#因为使用的是HyperLogLog++算法
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":"0",
    "aggs":{
        "test_cardinality":{
            "cardinality":{
                "field":"grade"
            }
        }
    }
}'
#可以使用precision_threshold参数来提升精度，默认是3000。
#该参数允许交易内存的准确度，并定义一个唯一的计数，低于该计数接近准确，高于该值可能变得模糊。支持的最大值为40000。
#即便是阈值为100，在计算百万数据的时候错误率仍然非常低。