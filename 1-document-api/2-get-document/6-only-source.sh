#!/bin/bash
# 可以使用_source endpoint只获取source字段，不包含其他字段
# 同样的，可以使用?_source_includes进行过滤，使用head进行检验

curl -X GET 'localhost:9200/building/_doc/1/_source?pretty'
curl -I 'localhost:9200/building/_doc/1/_source?pretty'
