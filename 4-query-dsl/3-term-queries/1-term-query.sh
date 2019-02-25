#!/bin/bash
#term query是查找包含在倒排索引中指定的确切项的文档，相当于status=1此类的查询
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "term":{
            "name":"1006"
        }
    }
}'
#可以指定boost参数，使得该term查询的权重高于其他查询。默认的权重是1.0
#注意，如果一个字段是text类型的，则使用term查询时，我们需要传入的请求文本需要根据text类型文本的分词结果来确定。
#因为text文本被索引至倒排索引时，对其文本进行了分词，倒排索引中存储的是词条列表。
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "term":{
            "message":"this is"
        }
    }
}'
#此处的this is无法查询，因为被分词成了this、is两个词条，需要使用this或is进行查询