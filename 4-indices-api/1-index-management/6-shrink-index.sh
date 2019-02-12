#!/bin/bash
#shrink api允许压缩一个已经存在的索引的主分片数量。压缩后的分片数量必须是源分片数量的因子。在压缩之前，源索引的主分片与副分片必须处于同一节点上。
#如一个源索引分片数量为4，那压缩后的分片只能为1或2。如源分片为5，那压缩后分片只能为1。
#压缩过程如下：
#1. 创建一个与源索引相同配置的目标索引，主分片数少于源索引。
#2. 将源索引中的片段硬链接（不支持硬链接的文件系统将会复制整个目录，会更加耗时）到目标索引。
#3. 恢复目标索引，过程像是打开一个关闭的索引。
echo '创建一个源索引'
curl -X PUT 'localhost:9200/shrink_test_source?pretty' -H 'content-type:application/json' -d '{
    "settings":{
        "index.number_of_shards":4,
        "index.number_of_replicas":1
    }
}'
curl -X PUT 'localhost:9200/shrink_test_source/_doc/1' -H 'content-type:application/json' -d '{
    "message":"1111111"
}'
curl -X PUT 'localhost:9200/shrink_test_source/_doc/2' -H 'content-type:application/json' -d '{
    "message":"22222"
}'
curl -X PUT 'localhost:9200/shrink_test_source/_doc/3' -H 'content-type:application/json' -d '{
    "message":"3333"
}'
curl -X PUT 'localhost:9200/shrink_test_source/_doc/4' -H 'content-type:application/json' -d '{
    "message":"44444"
}'
curl -X PUT 'localhost:9200/shrink_test_source/_doc/5' -H 'content-type:application/json' -d '{
    "message":"5555"
}'
echo '强制将每个分片的重新定位到某个节点上，并且将索引设置为不可写。'
curl -X PUT 'localhost:9200/shrink_test_source/_settings?pretty' -H 'content-type:application/json' -d '{
    "settings":{
        "index.routing.allocation.require._name":"node-1",
        "index.blocks.write":true
    }
}'


echo '设置目标索引的配置，并将源索引对于写入操作的限制、分配的设置清空'
curl -X POST 'localhost:9200/shrink_test_source/_shrink/shrink_test_target?copy_settings=true&pretty' -H 'content-type:application/json' -d '{
    "settings":{
        "index.routing.allocation.require._name":null,
        "index.blocks.write":null,
        "index.number_of_shards":2,
        "index.number_of_replicas":0,
        "index.codec":"best_compression"
    }
}'

# echo '按需清空源索引的设置'
# curl -X PUT 'localhost:9200/shrink_test_source/_settings?pretty' -H 'content-type:application/json' -d '{
#     "settings":{
#         "index.routing.allocation.require._name":null,
#         "index.blocks.write":null
#     }
# }'

#整个过程中可以使用wait_for_active_shards等待，可以使用_cat recover api 或cluster health api 监控