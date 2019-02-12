#!/bin/bash
#默认情况下，put命令会自动创建不存在的索引，如果我们不希望如此，可以通过设置cluster的action.auto_create_index来启用或禁用自动创建索引。
curl -X PUT 'localhost:9200/_cluster/settings?pretty' -H 'content-type:application/json' -d '
{
    "persistent":{
        "action.auto_create_index":"false"
    }
}
'

#action.auto_create_index也可包含一个列表，来禁用或启用部分索引的自动创建。如：
#action.auto_create_index:"building,+b*,-u*"。加号标识允许，减号标识不允许，*为通配符，默认为加号。
