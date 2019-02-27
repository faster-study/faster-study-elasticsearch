#!/bin/bash
curl -X DELETE 'localhost:9200/test_metric?pretty'
curl -X PUT 'localhost:9200/test_metric?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "grade":{
                    "type":"float"
                },
                "weight":{
                    "type":"integer"
                },
                "location":{
                    "type":"geo_point"
                }
            }
        }
    }
}'
curl -X POST 'localhost:9200/test_metric/_doc?pretty' -H 'content-type:application/json' -d '{
    "grade": 10,
    "weight":2,
    "location": "52.374081,4.912350"
}'
curl -X POST 'localhost:9200/test_metric/_doc?pretty' -H 'content-type:application/json' -d '{
    "grade": 30,
    "weight":1,
    "location": "52.369219,4.901618"
}'
curl -X POST 'localhost:9200/test_metric/_doc?pretty' -H 'content-type:application/json' -d '{
    "grade": 23.8,
    "location": "52.371667,4.914722",
    "weight":2
}'
curl -X POST 'localhost:9200/test_metric/_doc?pretty' -H 'content-type:application/json' -d '{
    "grade": 99.9,
    "location": "51.222900,4.405200",
    "weight":1
}'
curl -X POST 'localhost:9200/test_metric/_doc?pretty' -H 'content-type:application/json' -d '{
    "grade": 50.3,
    "location": "48.861111,2.336389",
    "weight":2
}'
curl -X POST 'localhost:9200/test_metric/_doc?pretty' -H 'content-type:application/json' -d '{
    "grade": 40.3,
    "location": "48.860000,2.327000",
    "weight":1
}'
curl -X POST 'localhost:9200/test_metric/_refresh?pretty'