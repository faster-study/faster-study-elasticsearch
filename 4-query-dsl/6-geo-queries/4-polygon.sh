#!/bin/bash
curl -X GET 'localhost:9200/distance-query-test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "bool":{
            "filter":{
                "geo_polygon":{
                    "location":{
                        "points":[
                            "40.13997,-71.319303",
                            "40.10179,-71.408415",
                            "40.094284,-71.291707"
                        ]
                    }
                }
            }
        }
    }
}'