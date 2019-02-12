#!/bin/bash
#explain可以计算查询特定文档的分数说明，可以提供有用的反馈。必须提供索引和id。
#返回内容与search body中的explain:true类似。
curl -X GET 'localhost:9200/test_scroll/_doc/1/_explain?pretty&q=*'