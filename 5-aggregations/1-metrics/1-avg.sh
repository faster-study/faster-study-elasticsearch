#!/bin/bash
#一种single-value度量聚合，从聚合文档中提取的数值进行球平均值。可以从文档中特定的数值类型的字段中提取，也可以通过脚本生成。
#默认情况下，会返回前10条数据，如果只需要返回聚合结果，则可以设置size为0
echo '正常查询'
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "avg_grade":{
            "avg":{
                "field":"grade"
            }
        }
    }
}'
#missing:10 默认情况下，如果字段不存在数据，会被忽略，missing:10为字段指定一个默认值。
echo '使用script进行查询'
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "avg_grade":{
            "avg":{
                "script":{
                    "source":"doc.grade.value"
                }
            }
        }
    }
}'