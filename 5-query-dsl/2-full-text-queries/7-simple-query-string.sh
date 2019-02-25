#!/bin/bash
#simple_query_string查询永远不会抛出异常，并丢弃查询无效的部分。
curl -X GET "localhost:9200/search_test/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "simple_query_string" : {
        "query": "this is + 1007",
        "fields": ["message", "name"]
    }
  }
}
'