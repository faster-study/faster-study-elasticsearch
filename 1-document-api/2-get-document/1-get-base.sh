#!/bin/bash
# get api 允许从索引中使用id获取文档。基本的示例如下：
curl -X GET 'localhost:9200/building/_doc/1?pretty'