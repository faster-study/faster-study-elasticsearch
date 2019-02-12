#!/bin/bash
#capbility允许检索多个索引之间的字段能力
curl -X GET 'localhost:9200/test_scroll/_field_caps?pretty&fields=message'

#返回参数详解：
#searchable:是否支持搜索。
#aggregatable:是否支持聚合。
#indices:此字段具有相同类型的索引列表。
#non_searchable_indices:此字段不可用于搜索的索引列表。
#non_aggregatable_indices:此字段不可聚合的索引列表。