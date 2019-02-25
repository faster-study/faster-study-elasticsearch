#!/bin/bash
#支持的数值类型如下：
#long:64位，-2的63次方到2的63次方-1
#integer:32位。-2的31次方到2的31次方-1
#short:16位。-2的15次方到2的15次方减1
#byte:8位。-2的7次方到2的7次方减1
#double: 64位双精度。
#float: 32位单经度。
#half_float: 16位半精度.
#scaled_float: 缩放浮点。2的-24次方到65504。存储的是整数，操作时还是按照浮点操作。
echo '各种类型测试'
curl -X DELETE 'localhost:9200/test_number'
curl -X PUT 'localhost:9200/test_number?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "properties":{
                "number_long":{
                    "type":"long"
                },
                "number_integer":{
                    "type":"integer"
                },
                "number_short":{
                    "type":"short"
                },
                "number_byte":{
                    "type":"byte"
                },
                "number_double":{
                    "type":"double"
                },
                "number_float":{
                    "type":"float"
                },
                "number_half_float":{
                    "type":"half_float"
                },
                "number_scaled_float":{
                    "type":"scaled_float",
                    "scaling_factor":100
                }
            }
        }
    }
}'

curl -X PUT 'localhost:9200/test_number/_doc/1?pretty' -H 'content-type:application/json' -d '{
    "number_long":111111111111111111,
    "number_integer":22222222,
    "number_short":333,
    "number_byte":11,
    "number_double":1121212.122112,
    "number_float":444444.222,
    "number_half_float":11112.22,
    "number_scaled_float":122.33223
}'

curl -X GET 'localhost:9200/test_number/_doc/1?pretty'
