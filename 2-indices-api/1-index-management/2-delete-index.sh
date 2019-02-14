#!/bin/bash
#删除索引的api允许删除已经存在的索引
echo '删除索引'
curl -X DELETE 'localhost:9200/building?pretty'
#可以通过_all或者*通配符来删除索引。
echo '删除全部索引'
curl -X DELETE 'localhost:9200/_all?pretty'
#删除全部索引或使用通配符删除存在风险，建议禁用此功能。
#可以配置yml文件的action.destructive_requires_name=true来禁用全部删除或通过通配符删除。或者通过集群api禁用。
#action.destructive_requires_name是全局的。所有涉及到的_all或者通配符都将不可用。