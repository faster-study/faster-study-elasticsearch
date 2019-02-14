#!/bin/bash
#批量搜索，_msearch，与之前的批量索引、批量更新规则一致
curl -X GET 'localhost:9200/_msearch?pretty' -H 'content-type:application/x-ndjson' -d '
{"index":"test_highlighting"}
{"query":{"match_all":{}},"from":0,"size":1}
{"index":"search_test"}
{"query":{"match":{"message":"1"}}}
'