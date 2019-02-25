#!/bin/bash
#match_phrase_prefix允许在文本的最后一个词上进行前缀匹配
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_phrase_prefix":{
            "message":"this is 1"
        }
    }
}'
#上面的例子中，会匹配this is这个短语，并且会将索引中在this is之后以1开头的的文档均进行返回。
#可以接受max_expansions参数，控制最后一项将匹配的前缀的数量，以减少内存和查询时间。