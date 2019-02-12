#!/bin/bash
# 如果使用路由创建索引，同样的需要使用路由进行删除
curl -X DELETE 'localhost:9200/building/_doc/1?routing=testRouting&pretty'