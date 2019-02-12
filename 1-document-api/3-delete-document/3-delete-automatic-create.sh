#!/bin/bash
#使用外部版本号时，删除操作将会创建未存在的索引。如果存在索引但某些属性未存在类型，也会为特定类型创建动态类型映射。
curl -X DELETE 'localhost:9200/people/_doc/1?pretty&version_type=external&version=1'