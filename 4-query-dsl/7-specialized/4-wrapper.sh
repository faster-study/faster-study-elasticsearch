#!/bin/bash
#wrapper查询允许使用base64格式的字符串进行查询
curl -X GET "localhost:9200/_search?pretty" -H 'Content-Type: application/json' -d'
{
    "query" : {
        "wrapper": {
            "query" : "eyJ0ZXJtIiA6IHsgInVzZXIiIDogIktpbWNoeSIgfX0=" 
        }
    }
}
'
