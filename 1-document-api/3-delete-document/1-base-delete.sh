#!/bin/bash
# 使用delete方法可以删除文档
curl -X DELETE 'localhost:9200/building/_doc/1?pretty'
