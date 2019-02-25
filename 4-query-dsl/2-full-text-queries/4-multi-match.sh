#!/bin/bash
#multi_match查询基于match查询且允许多字段查询构建。
echo '查询message和name参数，查询文本使用this a 1007'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "multi_match":{
            "query":"this is a 1007",
            "fields":["message","name"]
        }
    }
}'
#可以看到返回结果中，name为1007的文档，分数最高
#fields参数可以使用通配符来表示字段如mess*
#可以使用^(倍数)来标识某个字段的重要性，如message^3，表示message字段的重要性是普通的字段的3倍
#可以指定查询类型
#best_fields:默认值，查找与任何字段匹配的文档，使用最佳字段中的权重。
#most_fields:查找与任何字段匹配的文章，并组合每个字段的权重
#phrase:对每个字段运行match_phrase查询，并合并每个字段的权重
#phrase_prefix:对每个字段运行match_phrase_prefix查询，并合并每个字段的权重
#cross_fields:使用相同的分析器处理字段，就像他们是一个大字段，并合并每个字段的权重。
