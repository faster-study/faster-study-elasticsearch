#!/bin/bash
#通过get获取索引的信息，同样可以使用_all或通配符,action.destructive_requires_name对此同样有用
curl -X GET 'localhost:9200/building?pretty'