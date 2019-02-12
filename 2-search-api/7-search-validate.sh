#!/bin/bash
#_validate/query可以检验搜索的请求而不执行
curl -X GET 'localhost:9200/test_scroll/_validate/query?pretty&q=*'