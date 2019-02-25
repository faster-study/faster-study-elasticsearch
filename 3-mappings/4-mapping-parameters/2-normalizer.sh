#!/bin/bash
#针对于keyword类型的字段，在索引该类型字段之前以及查询该类型字段时使用。
curl -X PUT "localhost:9200/index" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "analysis": {
      "normalizer": {
        "my_normalizer": {
          "type": "custom",
          "char_filter": [],
          "filter": ["lowercase", "asciifolding"]
        }
      }
    }
  },
  "mappings": {
    "type": {
      "properties": {
        "foo": {
          "type": "keyword",
          "normalizer": "my_normalizer"
        }
      }
    }
  }
}
'
curl -X PUT "localhost:9200/index/type/1" -H 'Content-Type: application/json' -d'
{
  "foo": "BÀR"
}
'
curl -X PUT "localhost:9200/index/type/2" -H 'Content-Type: application/json' -d'
{
  "foo": "bar"
}
'
curl -X PUT "localhost:9200/index/type/3" -H 'Content-Type: application/json' -d'
{
  "foo": "baz"
}
'
curl -X POST "localhost:9200/index/_refresh"
curl -X GET "localhost:9200/index/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "term": {
      "foo": "BAR"
    }
  }
}
'
curl -X GET "localhost:9200/index/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "foo": "BAR"
    }
  }
}
'
