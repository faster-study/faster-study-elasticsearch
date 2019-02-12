#!/bin/bash
# get请求可以通过refresh参数在get操作前刷新搜索不可见的文档。该操作不会导致系统负载过重或减慢索引速度。
curl -X GET 'localhost:9200/building/_doc/1?pretty&refresh'