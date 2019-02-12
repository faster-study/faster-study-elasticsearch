#!/bin/bash
# 默认情况下使用PUT进行索引文档，需要指定索引id，使用POST请求索引时，elasticsearch会自动创建id。
curl -X POST 'localhost:9200/building/_doc?pretty' -H 'content-type:application/json' -d '
{
    "message":"automatic id"
}
'