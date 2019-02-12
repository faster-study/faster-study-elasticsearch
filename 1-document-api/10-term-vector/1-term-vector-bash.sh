#!/bin/bash
#词条向量
#elasticsearch允许我们统计文档中词条的信息。可以指定多个字段。不存在的文档也可以进行计算，请求中提供文档(doc字段)。
#可选参数：
#position:true 词组的位置
#offsets:true 词组的偏移量
#payloads:true base64编码
#term_statistics:true 词条次数、频率，默认为false
#field_statistics:true 某个字段词条去重的数量、词的数量、涉及文档的数量等。
#filter，增加该节点以及子节点，可以过滤统计结束后的数据，支持的子节点如下：
##max_num_terms: 统计结果中返回的词组数量，默认为25。按照评分倒序
##min_term_freq: 忽略源文档中低于此频率的词组，默认为1。
##max_term_freq: 忽略源文档中超过此频率的词组，默认为无限制。
##min_doc_freq: 忽略在文档中出现次数小于此值的词组，默认为1。
##max_doc_freq: 忽略在文档中出现次数高于此值的词组，默认为无限制。
##min_word_length: 忽略低于该长度的词组。默认为0
##max_word_length: 忽略高于该长度的词组，默认为unbounded（0），为0时不忽略。
curl -X DELETE 'http://localhost:9200/test_term_vector/?pretty'
curl -X PUT 'http://localhost:9200/test_term_vector?pretty' -H 'content-type:application/json' -d '{
  "mappings":{
    "_doc":{
      "properties":{
        "name":{
          "type":"text",
          "analyzer":"smartcn"
        }
      }
    }
  }
}'
echo '添加基础数据'
curl -X PUT 'http://localhost:9200/test_term_vector/_doc/1?refresh&pretty' -H 'content-type:application/json' -d '{
    "name":"今天的天气不错。"
}'
curl -X GET 'http://localhost:9200/test_term_vector/_doc/1/_termvectors?pretty' -H 'content-type:application/json' -d '{
  "fields" : ["name"],
  "offsets" : true,
  "positions" : true,
  "term_statistics" : true,
  "field_statistics" : true,
  "filter":{
    "max_num_terms":25,
    "min_term_freq":1,
    "max_term_freq":10000
  }
}'

#检索不存在于索引中的文档，name必须是索引的某个属性
echo '文档不存在于索引中的向量检索'
curl -X GET 'http://localhost:9200/test_term_vector/_doc/_termvectors?pretty' -H 'content-type:application/json' -d '{
  "doc":{
    "name":"not exist document in indices"
  },
  "term_statistics": true,
  "field_statistics": true
}'
