#!/bin/bash
#post_filter api允许我们在所有处理最后进行过滤，聚合后也可以过滤，类似于sql中的having by。
echo '基础数据'
curl -X PUT 'localhost:9200/test_post_filter?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "color":{
                    "type":"keyword"
                },
                "lable":{
                    "type":"keyword"
                }
            }
        }
    }
}'

curl -X PUT 'localhost:9200/test_post_filter/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "color":"red",
    "label":"a"
}'

curl -X PUT 'localhost:9200/test_post_filter/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
    "color":"blue",
    "label":"a"
}'
curl -X PUT 'localhost:9200/test_post_filter/_doc/3?pretty&refresh' -H 'content-type:application/json' -d '{
    "color":"red",
    "label":"b"
}'
curl -X PUT 'localhost:9200/test_post_filter/_doc/4?pretty&refresh' -H 'content-type:application/json' -d '{
    "color":"red",
    "label":"a"
}'

echo '在聚合后仅展示label为b的数据。'

curl -X GET 'localhost:9200/test_post_filter/_search?pretty' -H 'content-type:application/json' -d '{
    "aggs":{
        "color_red":{
            "filter":{
                "term":{
                    "color":"red"
                }
            }
        }
    },
    "post_filter":{
        "term":{
            "label":"b"
        }
    }
}'