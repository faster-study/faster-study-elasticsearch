#!/bin/bash
#_count可以轻松获取查询结果的数量
curl -X GET 'localhost:9200/test_scroll/_count?pretty&q=*'