#!/bin/bash
# 可以使用refresh参数指定控制删除操作何时对搜索可见。参见refresh一节
# 在删除操作执行成功后刷新接收删除操作请求的分片。
curl -X DELETE 'localhost:9200/building/_doc/1?refresh&pretty'