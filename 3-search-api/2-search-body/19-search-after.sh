#!/bin/bash
#对于结果集的分页我们可以使用from、size完成，但当数据集过大时，即深度分页时，成本变的很高。
#elasticsearch默认设置了最大1万条数据作为保障。即from、size最多只能分页到1万条
#scroll api允许我们进行深度分页，但是并不适用于实时搜索，因为其上下文的代价很高。
#search_after参数通过提供实时游标来解决此问题，seach_after根据sort排序字段来进行滚动，使用上一页的sort字段值来检索下一页。
curl -X GET  'localhost:9200/test_scroll/_search?pretty' -H 'content-type:application/json' -d '{
    "size":10,
    "query":{
        "match_all":{}
    },
    "search_after":[22000],
    "sort":["num"]
}'
#search_after相比于scroll api来说仅仅是做到了无状态，但是真实情况下。
#如果处理非实时检索，scroll api扔会提供最好的性能。
#而如果处理实时检索，即便是search_after也无法做到随机跳页，即从第1页跳到第90页。
#search_after适用于顺序翻页的查询情况（如app端的点击加载更多，而不是pc端的分页组件）。