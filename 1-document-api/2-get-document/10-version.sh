#!/bin/bash
#可以使用version来限定版本号，版本类型在所有的方式中都是相同的。internal、external/external_gt、external_gte
curl -X GET 'localhost:9200/building/_doc/1?version=2&pretty'