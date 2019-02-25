#!/bin/bash
# 返回与提供的terms列表相匹配的文档，但是需要minimum_should_match_field或minimum_should_match_script指定最小匹配的数量。
curl -X PUT "localhost:9200/my-index?pretty" -H 'Content-Type: application/json' -d'
{
    "mappings": {
        "_doc": {
            "properties": {
                "required_matches": {
                    "type": "long"
                }
            }
        }
    }
}
'
curl -X PUT "localhost:9200/my-index/_doc/1?refresh&pretty" -H 'Content-Type: application/json' -d'
{
    "codes": ["ghi", "jkl"],
    "required_matches": 2
}
'
curl -X PUT "localhost:9200/my-index/_doc/2?refresh&pretty" -H 'Content-Type: application/json' -d'
{
    "codes": ["def", "ghi"],
    "required_matches": 2
}
'

curl -X GET "localhost:9200/my-index/_search?pretty" -H 'Content-Type: application/json' -d'
{
    "query": {
        "terms_set": {
            "codes" : {
                "terms" : ["abc", "def", "ghi"],
                "minimum_should_match_field":"required_matches"
            }
        }
    }
}
'
