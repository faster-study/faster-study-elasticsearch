#!/bin/bash
curl -X GET 'localhost:9200/test_metric/_search?pretty' -H 'content-type:application/json' -d '{
    "size":0,
    "aggs":{
        "test_percentile_ranks":{
            "percentile_ranks":{
                "field":"grade",
                "values":[10,20]
            }
        }
    }
}'