#!/bin/bash
#phrase suggest会考虑多个词之间的关系，比如是否同时出现在索引的原文中、相邻程度、频率等。
curl -X GET 'localhost:9200/test_highlighting/_search?pretty' -H 'content-type:application/json' -d '{
    "suggest":{
        "phrase-suggest":{
            "text":"天启不好",
            "phrase":{
                "field":"content",
                "highlight":{
                    "pre_tag":"<tag>",
                    "post_tag":"</tag>"
                },
                "direct_generator":[{
                    "field":"content",
                    "min_word_length":2
                }]
            }
        }
    }
}'

#direct_generator参数与term基本一致
#详情查看https://www.elastic.co/guide/en/elasticsearch/reference/current/search-suggesters-phrase.html