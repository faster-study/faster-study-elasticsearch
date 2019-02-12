#!/bin/bash
#默认情况下，delete_by_query批量删除的大小为1000，可以使用scroll_size参数指定大小
curl -X POST "localhost:9200/building/_delete_by_query?scroll_size=5000&pretty&q=*"