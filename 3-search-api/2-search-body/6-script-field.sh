#!/bin/bash
#允许使用脚本返回自定义的字段。
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_all":{}
    },
    "script_fields":{
        "name1":{
            "script":{
                "source":"doc[\"name\"].value+1"
            }
        }
    }
}'

#此处script中的doc["name"]，name字段的类型必须为可检索类型的。
#也可以使用params[\"_source\"][\"name\"]+1实现同样效果。
#两者相比：doc会将字段的内容加载到内存中，效率会更快。params["_source"]每次都需要加载和解析，非常慢。建议使用doc