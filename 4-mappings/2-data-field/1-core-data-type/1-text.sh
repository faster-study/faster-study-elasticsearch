#!/bin/bash
#用于全文检索的字段（如文章内容）。可以指定analyzer（分词器），通过分词器将其转换成词组列表。
#分析过程允许elasticsearch搜索每个全文本字段中的单个词组。
#无法用于排序
#可以用于聚合但是尽量不使用
echo '设置全文检索类型'
curl -X PUT 'localhost:9200/mapping_text?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "full_name":{
                    "type":"text"
                }
            }
        }
    }
}'
echo '结果'
curl -X GET 'localhost:9200/mapping_text/_mapping?pretty'
