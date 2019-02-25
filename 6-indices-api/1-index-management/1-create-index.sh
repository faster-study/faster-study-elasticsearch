#!/bin/bash
#在es中所有的文档都存储在索引内部。创建索引的api允许我们手动创建索引。
echo '创建一个默认配置的索引：'
curl -X PUT 'localhost:9200/building?pretty'
#创建索引时，索引的名称具有如下限制：
#1. 仅限小写
#2. 不能包括\、/、*、?、"、<、>、|、空格、,、#
#3. 7.0之前版本可以包含冒号，7+以上不支持
#4. 不能以-、_、+开头
#5. 不能是.或者..
#6. 不能超过255个字节（不是字符，有的字符包含多个字节）
echo '创建索引指定分片settings'
curl -X PUT 'localhost:9200/building_specific_settings?pretty' -H 'content-type:application/json' -d '{
    "settings":{
        "number_of_shards":"1",
        "number_of_replicas":"0"
    }
}'
#更多的索引配置在索引模块详细介绍。
#创建索引时还可以指定mappings，在mapping一节中介绍。