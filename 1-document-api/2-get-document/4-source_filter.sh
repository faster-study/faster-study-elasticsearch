#!/bin/bash
# 默认情况下，get api 会返回_source字段，如需禁用使用_source=false
# 可以使用_source_includes=name&_source_excludes=address来控制字段的返回
# 或者可以直接使用_source=name,*Num来展示部分字段
curl -X GET 'localhost:9200/building/_doc/1?_source=name,*Num&pretty'