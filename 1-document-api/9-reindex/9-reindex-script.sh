#!/bin/bash
#可以使用script脚本来操作文档，本例子复制时，将版本号直接设置为4,将name修改为update test
curl -X POST 'localhost:9200/_reindex?pretty&refresh' -H 'content-type:application/json' -d '{
    "source":{
        "index":"test"
    },
    "dest":{
        "index":"new_test_script",
        "version_type":"external"
    },
    "script":{
        "source":"if(ctx._source.name==\"test4\") {ctx._version=4;ctx._source.name=\"update test\"}"
    }
}'

curl -X GET 'localhost:9200/new_test_script/_doc/1?pretty'