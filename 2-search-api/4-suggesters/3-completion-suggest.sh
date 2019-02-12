#!/bin/bash
#completion-suggest可以说是最常用的建议，它提供了补全的功能。在用户输入一个字符即给出后续建议。
#其实现方式也针对这种场景做了优化，满足高效搜索，但是所要求的内存也更高（不影响）。
#需要将字段设置为completion类型
curl -X GET 'localhost:9200/test_highlighting/_search?pretty' -H 'content-type:application/json' -d '{
    "suggest":{
        "completion-suggest":{
            "prefix":"天气",
            "completion":{
                "field":"message"
            }
        }
    }
}'

# skip_duplicates: 跳过重复的建议，在completion节点内部
# size:设置每个建议返回的数量，在completion节点内部
# 可以使用fuzzy设置模糊查询，在completion节点内部
# 可以使用regex节点，设置正则匹配，替换prefix