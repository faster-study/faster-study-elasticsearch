#!/bin/bash
#suggester提供建议词组的功能。类似百度、谷歌搜索时的自动提示。检索建议包含了补全与纠正两大功能。
#而term suggest是基于analyzer分词器分成多个相似的单词放入options中，并不会考虑多个词之间的关系。api调用方只需为每个返回的词中的options挑选一个单词即可。
#可以与query一起使用，如果省略query，则只返回建议
curl -X GET 'localhost:9200/test_highlighting/_search?pretty&typed_keys' -H 'content-type:application/json' -d '{
    "suggest":{
        "term-suggest":{
            "text":"天启",
            "term":{
                "min_word_length":2,
                "field":"content"
            }
        }
    }
}'
#typed_keys参数可以在返回值中携带suggester类型，<type>#<name>
#可选参数:
#text:建议文本，必须。
#field:建议字段，必须。
#analyzer:分析器，默认使用字段的分析器。
#size:每个建议文本返回的最大数量
#sort:排序,可选：score先按分数排序，然后按文档频率排序，最后按术语本身排序。frequency先按文档频率排序，然后按相似性分数排序，然后按术语本身排序。
#suggest_mode:模式。可选: missing仅提供不在索引中的建议文本术语的建议，默认值。popular仅提供比原始文本更多的文档中出现的建议。always根据文本提供任何匹配的建议。
#lowercase_terms:在文本分析之后降低建议文本的大小写。
#max_edits: 可以被视为建议的最大编辑距离，只能是1和2，默认为2.
#prefix_length:必须匹配的最小前缀字符的数量才能算作候选建议，默认为1，增加此数字可提高拼写检查性能。通常拼写错误不会出现在开头。
#min_word_length:建议文本术语必须具有的最小长度。默认为4。汉字建议默认设置为2。
#shard_size:从每个分片中检索的最大建议数。
#max_inspections:用于乘以的因子，以便在碎片级别上检查更多候选拼写更正。默认为5，可以提高，牺牲性能提高准确性。
#min_doc_freq:建议应出现的文档数量的最小阈值。
#max_term_freq:建议文本可以存在文档数量的最大阈值。
#string_distance:比较算法选择。可以指定五个可能的值： 
## internal- 默认值。基于damerau_levenshtein，但高度优化用于比较索引中术语的字符串距离。
## damerau_levenshtein - 基于Damerau-Levenshtein算法的字符串距离算法。 
## levenshtein - 基于Levenshtein编辑距离算法的字符串距离算法。 
## jaro_winkler - 基于Jaro-Winkler算法的字符串距离算法。 ngram - 基于字符n-gram的字符串距离算法。