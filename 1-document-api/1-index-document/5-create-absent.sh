#!/bin/bash
# 可以使用op_type=create参数或_create url来指定本次请求为创建请求，如果已经存在，则创建失败。
curl -X PUT 'localhost:9200/building/_doc/1/_create?pretty' -H 'content-type:application/json' -d '
{
    "message":"put if absent"
}
'