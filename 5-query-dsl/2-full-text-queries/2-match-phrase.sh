#!/bin/bash
#match_phrase分析查询文本，并从分析的文本中创建短语查询，要求所有的短语都被匹配。
echo '简单的短语查询'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_phrase":{
            "message":{
                "query":"this is"
            }
        }
    }
}'
#如果此处扔使用this is a test便不会被查询到，因为在查询时，我们的文档中并没有顺序一致的短语。
#可以使用slop参数来使得短语位置不一定一致。
echo 'slop控制短语位置不一致'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_phrase":{
            "message":{
                "query":"is this",
                "slop":10
            }
        }
    }
}'
