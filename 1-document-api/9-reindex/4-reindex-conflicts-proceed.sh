#!/bin/bash
#可以使用conflicts:proceed参数在遇到错误时不中止整个过程。
curl -X POST 'localhost:9200/_reindex?pretty' -H 'content-type:application/json' -d '{
    "source":{
        "index":"test"
    },
    "dest":{
        "index":"new_test",
        "op_type":"create"
    },
    "conflicts":"proceed"
}'