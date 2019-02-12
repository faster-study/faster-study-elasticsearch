#!/bin/bash
curl -X POST 'localhost:9200/building/_update_by_query?pretty' -H 'content-type:application/json' -d '{
    "script":{
        "source":"ctx._source.peopleNum++"
    },
    "query":{
        "match":{
            "name":"建筑"
        }
    }
}'