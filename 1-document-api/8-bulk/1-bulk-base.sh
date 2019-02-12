#!/bin/bash
#可以使用_bluk端点进行批量操作。格式为:
# action_and_meta_data\n
# optional_source\n
# action_and_meta_data\n
# optional_source\n
#必须以换行符结尾,content-type设置为application/x-ndjson

curl -X POST 'localhost:9200/_bulk?pretty' -H 'content-type:application/x-ndjson' -d '
{"index":{"_index":"test","_type":"_doc","_id":"1"}}
{"field1":"value1"}
{"delete":{"_index":"test","_type":"_doc","_id":"2"}}
{"create":{"_index":"test","_type":"_doc","_id":"3"}}
{"field1":"value3"}
{"update":{"_id":"1","_index":"test","_type":"_doc"}}
{"doc":{"field2":"value2"}}
'