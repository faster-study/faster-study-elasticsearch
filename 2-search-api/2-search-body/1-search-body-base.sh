#!/bin/bash
#搜索api可以在请求体中传递搜索DSL（包含了查询SDL），来进行搜索。
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "term":{
            "name":"1001"
        }
    }
}'

#可以在请求体中包含如下参数：
#timeout:超时时间
#from:分页请求，从0开始
#size:每页数量
#search_type:搜索类型，需要在uri参数中指定。可选dfs_query_then_fetch和query_then_fetch，默认为query_then_fetch，更多在搜索类型一节解释。
#request_cache:需要在uri参数中指定。缓存结果为size为0的请求。更多在Shard请求缓存中介绍。
#allow_partial_search_results：需要在uri参数中指定。是否允许在出现异常时返回部分结果。默认为true。设置为false，出现异常时返回失败，不返回结果。
#terminate_after:每个分片搜索的文档数量，获取后就中止对该分片的查询。
#batched_reduce_size：每次搜索请求会扫描多个分片，当分片过多时，提前返回的结果会驻留在内存中导致内存占用过多。
#该参数可以指定当返回多少分片结果后进行压缩合并以释放内存。默认为512。
#当压缩合并大于1次时，会在结果集中返回num_reduce_phases参数表示本次压缩合并的次数。