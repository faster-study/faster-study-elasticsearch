#!/bin/bash
#search api 允许使用uri参数的方式来进行搜索。该种方式并不是所有的搜索选项都支持，但是这种方式可以很方便的进行测试。
#q参数，相当于query_string查询，更多的用法会在query DSL一节中介绍。
echo 'q参数使用'
curl 'localhost:9200/search_test/_search?q=name:1001&pretty'
#以下为所支持的参数
#df：q中未指定查询字段时使用的默认字段。
#analyzer：指定使用的分析器
#analyze_wildcard：是否分析通配符和前缀查询，默认为false。
#batched_reduce_size：每次搜索请求会扫描多个分片，当分片过多时，提前返回的结果会驻留在内存中导致内存占用过多。
#该参数可以指定当返回多少分片结果后进行压缩合并以释放内存。默认为512。
#当压缩合并大于1次时，会在结果集中返回num_reduce_phases参数表示本次压缩合并的次数。
#此处设置2，可以看到结果中返回了压缩次数为4（因为有5个分片，两两合并有3次，再将3次结果进行合并，为4次。）
echo 'batched_reduce_size参数:'
curl 'localhost:9200/search_test/_search?q=*&pretty&batched_reduce_size=2'
#default_operator：请求中可以包含多个q，如: q=a:1&q=b:2，该参数可以指定多个查询条件之间的关系，默认是or，可以选值为or和and。
#lenient:是否允许类型转换异常，如果一个数字类型的字段，使用字符串进行搜索，会抛出异常。默认为false（测试中默认为true）。允许true/false。
#_source:设置为false禁用_source字段检索。或者指定要返回的字段，还可以使用_source_includes和_source_excludes检索部分字段。
echo '_source参数:'
curl 'localhost:9200/search_test/_search?q=name:1001&pretty&_source=name'
#stored_fields:返回mapping中设置stored为true的字段
#sort:排序，可以有多个
echo 'sort参数:'
curl 'localhost:9200/search_test/_search?q=*&pretty&sort=_id:desc'
#track_scores: 设置为true，排序时返回分数，默认为false。
#track_total_hits：设置为false不展示匹配总数。默认为true。hits节点中的total会变为-1
echo 'track_total_hits参数:'
curl 'localhost:9200/search_test/_search?q=*&pretty&track_total_hits=false'
#timout：超时时间，默认为不超时
#terminate_after：控制从每个分片中返回的文件最大数量。
echo 'terminate_after参数:'
curl 'localhost:9200/search_test/_search?q=*&pretty&terminate_after=1'
#from: 分页起始
#size: 分页每页数量
#search_type: 可以为dfs_query_then_fetch或query_then_fetch，默认为query_then_fetch。类型在搜索类型一节中介绍。
#allow_partial_search_results: 是否允许当请求失败时返回部分结果，默认为true。设置为false，失败时不会返回搜索结果，返回整体故障