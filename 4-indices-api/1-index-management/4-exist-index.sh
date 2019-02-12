#!/bin/bash
#检查索引是否存在,200表示存在，404不存在
curl -I 'localhost:9200/building?pretty'