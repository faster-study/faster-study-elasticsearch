#!/bin/bash
#highlighting节点允许在搜索结果中展示一个或多个高亮字段，以便向用户显示查询所匹配的位置。
#在返回结果中，会返回highlight节点，该节点下包含高亮字段和该字段所在的片段。

echo '基础数据'
curl -X DELETE 'localhost:9200/test_highlighting'
curl -X PUT 'localhost:9200/test_highlighting?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "content":{
                    "type":"text",
                    "analyzer":"ik_smart"
                },
                "message":{
                    "type":"completion",
                    "analyzer":"ik_smart"
                }
            }
        }
    }
}'
curl -X PUT 'localhost:9200/test_highlighting/_doc/1?pretty&refresh' -H 'content-type:application/json' -d '{
    "content":"今天的,天气非常好，可以出去钓鱼的天气。收拾一下，明天出去钓鱼吧。",
    "num":"在这个天气，去了五次"
}'

curl -X PUT 'localhost:9200/test_highlighting/_doc/2?pretty&refresh' -H 'content-type:application/json' -d '{
    "content":"明天的,天气不一定"
}'
curl -X PUT 'localhost:9200/test_highlighting/_doc/3?pretty&refresh' -H 'content-type:application/json' -d '{
     "content":"后天的,天气还可以"
}'
curl -X PUT 'localhost:9200/test_highlighting/_doc/4?pretty&refresh' -H 'content-type:application/json' -d '{
     "content":"昨天的,天气不好",
     "message":"天气就是不好"
}'
echo '基本用法'
curl -X GET 'localhost:9200/test_highlighting/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "content":"天气"
        }        
    },
    "highlight":{
        "fields":{
            "content":{
            }
        },
        "highlight_query":{
            "match":{
                "content":"钓鱼"
            }
        },
        "pre_tags":["<tag1>"],
        "post_tags":["</tag1>"]
    }
}'
#6.0之前fields节点下的字段可以指定为_all，需要在mapping中指定_all enabled true。6.0以后废弃_all，可以使用*代替。
#elasticsearch 的高亮分为三种类型：unified、plain、fvh（fast vector highlighter），可以在highlight节点下的type属性中指定。
#unified类型的highlighter使用lucene unified highlighter。官方建议使用默认的。
#这种类型的highlighter将文本内容分割成多个句子，并且使用BM25算法对每个句子进行评分。如同他们查询document一样。
#它还支持精确到短语和多词（模糊、前缀、正则）的高亮显示。
#plain类型的highlighter使用标准的Lucene highlighter。它试图在查询中理解单词的重要性和单词的定位来反应这次查询的匹配。（与term_vector类似）
#这种方式比较适合单个词语的查询匹配，因为他会将查询过程放入内存中进行（创建一个内存索引，使用lucene的查询执行计划程序重新运行原始查询，以便访问当前文档的细粒度的匹配信息）。
#如果要在复杂查询的大量文档中使用该种方式进行查询高亮词组，建议使用unfied或者term_vector（词组向量）。
#fvh类型的highlighter使用lucene Faster Vector Highlighter。不支持范围查询。

#highlightings有大量的参数设置，该设置可以设置为全局或者在字段进行设置，字段的优先级高于全局。参数如下：
#type:类型，可选：unified、plain、fvh
#boundary_chars: 分割使用的边界字符，值是一个字符串，默认的是：.,!?\t\n
#boundary_max_scan: 扫描边界字符的距离，默认是20
#boundary_scanner_locale: 控制使用哪个区域设置来搜索句子和单词边界，该参数支持国际化，默认值为Locale.ROOT。支持如："en-US"之类的参数
#boundary_scanner: 指定如何分割文本片段，chars、sentence、word三种。该参数只能用于unified和fvh类型的高亮。默认情况下，unified使用sentence，fvh使用chars。
##chars：使用由boundary_chars设置的边界字符和boundary_max_scan控制的扫描距离进行分割。
##sentence:使用java中BreakIterator确定的句子边界来分割，可以设置boundary_scanner_locale来指定使用哪个地域的语言分割。
##word:使用java中的BreakIterator确定的单词边界来分割。同样可以使用boundary_scanner_locale来设置地域
#encoder: 指示片段是否应为html编码：default或html。适用于plain类型。
#field:指定使用的字段。
#force_source:即使字段单独存储，也会根据源突出显示。
#fragmenter: 分段器，只适用于plain。可选span与simple。默认为span。
#fragment_offset: 查询的偏移量。仅在fvh有效。
#fragment_size: 每个高亮片段显示的高亮词组数量，默认为100。这个片段是根据boundary_scanner分割获得的。
#highlight_query: 突出搜索查询外的查询匹配项。默认情况下不会考虑这些。
#matched_fields: 仅支持fvh。组合多个字段上的匹配项以突出显示单个字段。
#no_match_size: 如果没有匹配到，从文本开头显示多少长度的文本，默认为0.
#number_of_fragments:匹配成功后返回的最大片段数量，默认为5。
#order：排序方式。默认情况下，按照字段出现的顺序进行返回（即order:none）。可以指定order:score
#phrase_limit:控制文本中匹配短语的数量，防止fvh分析太多的短语消耗大量内存。默认为256，仅支持fvh
#pre_tags:默认高亮被包含在<em>标签内，可以进行修改。前缀。使用fvh时，可以设置多个
#post_tags默认情况下被包含在</em>标签内，后缀。使用fvh时，可以设置多个
#require_field_match:默认情况下，仅高亮包含查询匹配的字段。设置为false包含全部。如一个query中只包含content，不包含message，那么高亮结果中只有content。如果想显示message，可设置该属性。如果不设置，即便highlight中的field，指定了message，也不会展示。
#tags_schema: 设置styled可以开启多个高亮展示时不同的class类名。也可以使用pre_tags和post_tags进行自定义
