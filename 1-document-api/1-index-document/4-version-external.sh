#!/bin/bash
# external类型要求携带的version必须大于索引的version
# 可选类型为external/external_gt  external_gte 
# external_gte允许大于等于之前版本，应小心使用此类型，如果使用不当会造成数据丢失。
curl -X PUT 'localhost:9200/building/_doc/1?version_type=external&version=4&pretty' -H 'content-type:application/json' -d '
{
    "message":"external version"
}
'