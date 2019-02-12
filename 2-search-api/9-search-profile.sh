#!/bin/bash
#profile提供了在搜索请求中执行单个组件的详细时间信息，他是一种调试工具，为搜索执行增加了大量的开销。
#让用户了解在底层如何执行搜索请求，这样用户可以理解为什么某些请求是缓慢的，并采取措施改善他们
#profile api输出非常详细，特别是对跨多个分片的复杂请求执行。
#profile提供的详细信息直接暴露了lucene的类名和概念，意味着对结果的完整解释需要lucene的高级知识。
curl -X GET 'localhost:9200/test_scroll/_search?pretty' -H 'content-type:application/json' -d '{
    "profile":true,
    "query":{
        "match":{
            "message":"1003"
        }
    }
}'