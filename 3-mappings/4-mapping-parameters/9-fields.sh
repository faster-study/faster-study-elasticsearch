#!/bin/bash
curl -X DELETE 'localhost:9200/test_fields'
curl -X PUT 'localhost:9200/test_fields?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "city":{
                    "type":"text",
                    "fields":{
                        "sort":{
                            "type":"keyword"
                        }
                    }
                }
            }
        }
    }
}'

curl -X PUT 'localhost:9200/test_fields/_doc/1?pretty&refresh' -H  'content-type:application/json' -d '{
    "city":"New York"
}'

curl -X GET 'localhost:9200/test_fields/_search?pretty' -H 'content-type:application/json' -d '{
    "sort":[{"city.sort":"desc"}],
    "query":{
        "match":{
            "city":"york"
        }
    }
}'