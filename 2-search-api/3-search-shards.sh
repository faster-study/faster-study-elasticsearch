#!/bin/bash
#search shards api 返回执行搜索请求的索引和分片。这可以为解决问题或使用路由和分片首选项规划优化提供有用的反馈
#index可以是单个值，也可以是逗号分隔。
curl -X GET 'localhost:9200/test_scroll/_search_shards?pretty'
#可选参数如下：
#routing:指定路由
#preference:指定在哪个分片副本上搜索，默认在分片副本之间随机。
#local:true/false，是否在本地节点搜索
