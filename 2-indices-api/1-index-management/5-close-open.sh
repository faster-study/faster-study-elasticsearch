#!/bin/bash
#可以通过open/close操作来打开/关闭索引的读写操作。这个api并不会减少集群的开销。
echo '关闭索引'
curl -X POST 'localhost:9200/building/_close?pretty'
echo '读取测试'
curl 'localhost:9200/building/_doc/1?pretty'
echo '打开索引'
curl -X POST 'localhost:9200/building/_open?pretty'
echo '读取测试'
curl 'localhost:9200/building/_doc/1?pretty'
echo '关闭多个索引'
curl -X POST 'localhost:9200/building,building_specific_settings/_close?pretty'
echo '打开多个索引'
curl -X POST 'localhost:9200/building,building_specific_settings/_open?pretty'
#当请求的索引不存在时会抛出异常，可以通过ignore_unavailable=true参数来禁用此检验。
#同样可以使用_all或者通配符来进行操作，action.destructive_requires_name对此同样有用。
#可以通过cluster.indices.close.enable=false来禁用关闭行为。
#因为封闭索引会占用大量磁盘空间，可能会导致环境出现问题。
#打开索引时，可以在参数中增加wait_for_active_shards来等待索引分片开启。