#!/bin/bash
#真实的业务场景中存在使用高性能查询的语法进行检索文档，如临近度查询（slop短语查询）。此时可能匹配出几百页的数据，而用户可能仅对前几页敢兴趣。
#rescore允许我们对每个分片的前N个结果进行重新匹配及计算分值，这个阶段指定的数据少，我们可以使用高昂的算法进行搜索。
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "message":{
                "query":"this"
            }
        }
    },
    "rescore":{
        "window_size": 1,
        "query":{
            "rescore_query":{
                "match_phrase":{
                    "message":{
                        "query":"1003",
                        "slop":2
                    }
                }
            }
        }
    }
}'