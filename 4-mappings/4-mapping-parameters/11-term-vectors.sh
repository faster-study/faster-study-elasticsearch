#!/bin/bash
curl -X PUT "localhost:9200/test_term_vectors?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "my_type": {
      "properties": {
        "text": {
          "type":        "text",
          "term_vector": "with_positions_offsets"
        }
      }
    }
  }
}
'
curl -X PUT "localhost:9200/test_term_vectors/my_type/1?pretty&refresh" -H 'Content-Type: application/json' -d'
{
  "text": "Quick brown fox"
}
'
curl -X GET "localhost:9200/test_term_vectors/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "text": "brown fox"
    }
  },
  "highlight": {
    "fields": {
      "text": {} 
    }
  }
}
'
