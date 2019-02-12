#!/bin/bash
# get请求可以使用preference参数选择分片组中的哪个分片处理请求（前文提到过读模型的第二个步骤是在分片组中确定哪个分片处理），默认情况下在主分片与副本分片中进行顺序随机。
# 方式有如下三种：
# 1. _primary 2. _local 3. 自定义的值，通过某个值来确定哪个分片，可以使用用户id或sessionId来实现随机一致性。

curl -X GET 'localhost:9200/building/_doc/1?pretty&preference=_local'
