curl -X DELETE 'localhost:9200/search_test?pretty'
curl -X PUT 'localhost:9200/search_test?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "location":{
                    "type":"geo_point"
                },
                "name":{
                    "type":"keyword",
                    "store":true
                }
            }
        }
    }
}'
curl -X POST 'localhost:9200/_bulk?pretty' -H 'content-type:application/x-ndjson' -d '
{"index":{"_index":"search_test","_type":"_doc","_id":"1"}}
{"name":"1001","message":"this is 1001","values":[1,2,3,4],"location":{"lat":40.722,"lon":"73.999"}}
{"index":{"_index":"search_test","_type":"_doc","_id":"2"}}
{"name":"1002","message":"this is 1002","values":[1],"location":{"lat":40.792,"lon":"73.999"}}
{"index":{"_index":"search_test","_type":"_doc","_id":"3"}}
{"name":"1003","message":"this is 1003","values":[4,3,2,1],"location":{"lat":40.742,"lon":"73.999"}}
{"index":{"_index":"search_test","_type":"_doc","_id":"1004"}}
{"message":"this is 1004","num":1004}
{"index":{"_index":"search_test","_type":"_doc","_id":"5"}}
{"name":"1005","message":"this is 1005","values":[1,2],"location":{"lat":40.799,"lon":"73.999"}}
{"index":{"_index":"search_test","_type":"_doc","_id":"6"}}
{"name":"1006","message":"this is 1006","values":[3,4],"location":{"lat":40.7654,"lon":"73.999"}}
{"index":{"_index":"search_test","_type":"_doc","_id":"7"}}
{"name":"1007","message":"this is 1007","location":{"lat":40.7122,"lon":"73.999"}}
'
