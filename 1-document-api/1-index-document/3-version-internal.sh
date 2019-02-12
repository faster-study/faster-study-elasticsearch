#!/bin/bash
#每个索引文档的信息里都包含一个version，用于乐观锁。我们可以在请求时携带version以达到乐观锁的效果。
#此处的version类型为internal（内部的），我们可以在url中指定version_type来改变版本号类型为external/external_gt或external_gte

curl -X PUT 'localhost:9200/building/_doc/1?version=1&pretty' -H 'content-type:application/json' -d '
{
    "message":"change version"
}
'