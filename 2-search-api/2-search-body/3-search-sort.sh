#!/bin/bash
#可以使用sort字段进行排序，在返回结果中会返回排序字段的排序值。
# 排序会将数据加载到内存中进行，尽量将参与排序的数值类型设置为较小的类型如short、integer、float。
echo '基本使用'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "sort":[
        {"_id":"asc"},
        {"_score":"desc"}
    ],
    "query":{
        "match_all":{}
    }
}'

echo '排序展示_score分数字段'
#默认情况下，sort排序不计算分数,即_score分数为null，可以使用track_scores:true来计算分数
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_all":{}
    },
    "track_scores":true,
    "sort":{
        "_id":"desc"
    }
}'


#es支持对数组或者多值的字段进行排序。可选参数如下:
#min、max、sum、avg、median
echo '对数组进行排序'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "sort":[
        {
            "values":{
                "order":"desc",
                "mode":"avg"
            }
        }
    ]
}'

# es支持在嵌套对象中进行排序，允许使用以下参数：
# path：定义要排序的嵌套对象。
# filter: 嵌套对象内部的过滤器，过滤嵌套对象内的数据
# max_children: 选择排序值时每个根文档要考虑的最大子项数。默认为无限制。
# nested:与顶级相同，适用于深层嵌套
# 脚本排序和地理位置排序也支持嵌套排序。
# 单层嵌套：
#    "sort" : [
#        {
#           "offer.price" : {
#              "mode" :  "avg",
#              "order" : "asc",
#              "nested": {
#                 "path": "offer",
#                 "filter": {
#                    "term" : { "offer.color" : "blue" }
#                 }
#              }
#           }
#        }
#     ]
# 深层嵌套：
#   "sort" : [
#       {
#          "parent.child.age" : {
#             "mode" :  "min",
#             "order" : "asc",
#             "nested": {
#                "path": "parent",
#                "filter": {
#                   "range": {"parent.age": {"gte": 21}}
#                },
#                "nested": {
#                   "path": "parent.child",
#                   "filter": {
#                      "match": {"parent.child.name": "matt"}
#                   }
#                }
#             }
#          }
#       }
#    ]

# missing可以指定当缺少排序字段时将该文档放在哪个位置，默认为_last（放在最后）。可选为：_last(放在最后)、_first(最前)和自定义字符串
echo 'missing参数，文档不存在参与排序的字段'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "sort":[
        {"values":{"missing":"8"}}
    ],
    "query":{
        "match_all":{}
    }
}'

#unmapped_type 如果要排序的字段，不存在于index mapping中，默认情况会报错，unmapped_type允许我们将这样的字段作为某个类型去排序。
# 下面结果返回的sort排序值很大，因为missing默认为_last
echo 'unmapped_type排序不存在的字段'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "sort":[
        {"a":{"unmapped_type":"long"}}
    ],
    "query":{
        "match_all":{}
    }
}'

#_geo_distance允许我们传入一个参考点，与文档中坐标类型的字段进行计算排序，_geo_distance节点包含参数如下：
#distance_type: 如何计算距离，可选值:arc(默认),plane(更快，但在长距离和靠近极点时不准确)
#mode:如果某个字段存在多个地址位置，即数组类型。如何处理。默认情况下，升序时使用min，降序使用max。支持的值是min，max，median，avg。
#unit:计算排序值时使用的单位，默认为m。
#ignore_unmapped:与普通字段排序一致。
#此示例中的location是文档中的一个字段，mapping类型是geo_point，此处传递的数组是经度和纬度。（前是经度，后是纬度）
echo 'geo test'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "sort":[
        {
            "_geo_distance":{
                "location":[73.99,40.72],
                "order":"asc",
                "unit":"km",
                "distance_type":"arc",
                "ignore_unmapped":true
            }
        }
    ]
}'

#location还是可以使用具体的对象，如：
# "location":{
#     "lat":"40.72",
#     "lon":"73.99"
# }

#还可以是字符串,注意，为字符串时变成了纬度在前，经度在后，与数组时不同。
# "location":"40.72,73.99"

#可以传递一个GeoHash算法生成的字符串。
#"location":"drm3btev3e86"

#可以传递多个经纬度（多个参考点进行排序），此时便用到了mode参数，以下例子会使用[71.99,41.72]参考点的计算结果作为排序值（该点距离文档中地理点的位置远，因为是desc排序）。
echo 'geo test many point'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "sort":[
        {
            "_geo_distance":{
                "location":[[73.99,40.72],[71.99,41.72]],
                "order":"desc",
                "unit":"km",
                "distance_type":"arc",
                "ignore_unmapped":true
            }
        }
    ]
}'

#允许使用_script脚本进行排序。
echo 'script排序'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match_all":{}
    },
    "sort":{
        "_script":{
            "type":"number",
            "script":{
                "source":"doc[\"values\"].get(0)*1.1"
            },
            "order":"desc"
        }
    }
}'
