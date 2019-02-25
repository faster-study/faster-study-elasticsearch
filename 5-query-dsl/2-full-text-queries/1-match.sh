#!/bin/bash
#match查询可以接受文本、数字及日期数据，进行分析然后构造查询。
echo '基本的match查询'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "message":"this is a test"
        }
    }
}'

#match 查询的类型是boolean类型，意味着分析所提供的文本中的词条，并且将其使用boolean语法（and、or）构建。
#match默认运算符为or，可以使用operator来设置，上述会分割成this or is or a or test这样的语法进行查询。
#可以使用mininum_should_match这个参数来设置要匹配的可选的should子句的最小数量。
echo '指定match查询的运算符为and'
curl -X GET 'localhost:9200/search_test/_search?pretty' -H 'content-type:application/json' -d '{
    "query":{
        "match":{
            "message":{
                "query":"this is a test",
                "operator":"and"
            }
        }
    }
}'
#可以指定analyzer控制分词过程。