#!/bin/bash
# curl -X PUT 'localhost:9200/specialized-more-like-this?pretty' -H 'content-type:application/json' -d '{
#     "mappings":{
#         "_doc":{
#             "properties":{
#                 "content":{
#                     "type":"text"
#                 }
#             }
#         }
#     }
# }'
# curl -X PUT 'localhost:9200/specialized-more-like-this/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
#     "content":"Magic Of Thinking Big", "description":"Millions of people throughout the world have improved their lives using The Magic of Thinking Big. Dr. David J. Schwartz, long regarded as one of the foremost experts on motivation, will help you sell better, manage better, earn more money, and—most important of all—find greater happiness and peace of mind."
# }'
# curl -X PUT 'localhost:9200/specialized-more-like-this/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
#     "content":"Magic Of Thinking Big", "description":"Millions of people throughout the world have improved their lives using The Magic of Thinking Big. Dr. David J. Schwartz, long regarded as one of the foremost experts on motivation, will help you sell better, manage better, earn more money, and—most important of all—find greater happiness and peace of mind."
# }'
curl -X GET 'localhost:9200/specialized-more-like-this/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "more_like_this":{
            "fields":["content"],
            "like":"Think Big",
            "min_term_freq" : 1,
            "min_doc_freq" : 1
        }
    }
}'
#文档输入参数
# like：MLT查询 的唯一必需参数是like并遵循通用语法，其中用户可以指定自由格式文本和/或单个或多个文档（参见上面的示例）。指定文档的语法类似于Multi GET API使用的语法。指定文档时，将从中提取文本，fields除非在每个文档请求中被覆盖。分析器在现场分析文本，但也可以覆盖。在字段处覆盖分析器的语法遵循与Term Vectors API的per_field_analyzer参数 类似的语法。另外，为了提供不一定存在于索引中的 文档，还支持人造文档。

# unlike：该unlike参数与结合使用like，以便不选择在所选文档集中找到的术语。换句话说，我们可以要求提供文件like: "Apple"，但是unlike: "cake crumble tree"。语法与like。相同。

# fields：用于获取和分析文本的字段列表。默认_all 为自由文本字段和文档输入的所有可能字段。

# like_text：文本找到喜欢它的文档。

# ids：要么 docs遵循与Multi GET API相同语法的文档列表。


# 词条相关参数：
# max_query_terms：将选择的最大查询字词数。增加此值可提高查询执行速度，从而提高准确性。默认为 25。

# min_term_freq：最小术语频率，低于该术语将忽略输入文档中的术语。默认为2。

# min_doc_freq：最低文档频率，低于该文档频率将忽略输入文档中的术语。默认为5。

# max_doc_freq：最大文档频率，高于该文档频率将忽略输入文档中的术语。这可以用于忽略诸如停用词之类的高频词。默认为unbounded（0）。

# min_word_length：最小字长，低于该字长将忽略这些术语。旧名称 min_word_len已弃用。默认为0。

# max_word_length：最大字长，高于该字长将忽略这些术语。旧名称 max_word_len已弃用。默认为unbounded（0）。

# stop_words：一系列停用词。这组中的任何单词都被认为是“无趣的”并被忽略。如果分析器允许停用词，你可能想要告诉MLT明确地忽略它们，因为文档相似性的目的似乎有理由假设“停止词永远不会有趣”。

# analyzer：用于分析自由格式文本的分析器。默认为与第一个字段关联的分析器fields。
#查询形成参数

# minimum_should_match：形成析取查询后，此参数控制必须匹配的术语数。语法与最小值匹配的语法相同。（默认为"30%"）。

# fail_on_unsupported_field：控制查询是否应该失败（抛出异常），如果任何指定的字段不是受支持的类型（text或keyword'). Set this to `false忽略该字段并继续处理。默认为 true。

# boost_terms：形成的查询中的每个术语可以通过其tf-idf分数进一步提升。这设置了使用此功能时要使用的提升因子。默认为停用（0）。任何其他正值都会激活使用给定提升因子提升的条件。

# include：指定输入文档是否也应包含在返回的搜索结果中。默认为false。

# boost：设置整个查询的提升值。默认为1.0。