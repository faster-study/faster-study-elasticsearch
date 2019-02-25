#!/bin/bash
#常用术语查询是停用词的现代替代，其提高了搜索结果的准确性和精确度且不牺牲性能。
curl -X GET "localhost:9200/search_test/_search?pretty" -H 'Content-Type: application/json' -d'
{
    "query": {
        "common": {
            "message": {
                "query": "this is 1007",
                "cutoff_frequency": 0.001
            }
        }
    }
}
'

