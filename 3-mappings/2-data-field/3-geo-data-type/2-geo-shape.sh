#!/bin/bash
#geo-shape支持更多的形状进行搜索（包括点）。
#必须适应geo_shape_query api来进行搜索，可以使用GeoJSON与Well-KnownText（WKT）来进行索引。
curl -X DELETE 'localhost:9200/test_geo_shape'
curl -X PUT 'lcoalhost:9200/test_geo_shape?pretty' -H 'content-type:application/json' -d '{
    "mappings":{
        "_doc":{
            "location":{
                "type":"shape"
            }
        }
    }
}'

echo '索引一个点 GeoJson'
curl -X POST 'localhost:9200/test_geo_shape/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
    "location":{
        "type":"point",
        "coordinates":[-77.11,38.22]
    }
}'
echo '索引一个点 WKT'
curl -X POST 'localhost:9200/test_geo_shape/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
    "location":"POINT (-77.11,38.22)"
}'

echo '索引一条线 GeoJson'
curl -X POST 'localhost:9200/test_geo_shape/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
    "location":{
        "type":"linestring",
        "coordinated":[[-77.036,38.89],[-77.009,38.888]]
    }
}'
echo '索引一条线 WKT'
curl -X POST 'localhost:9200/test_geo_shape/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
    "location":"LINESTRING (-77.036 38.89,-77.009 38.888)"
}'

echo '索引一个四边形,GeoJson'
curl -X POST 'localhost:9200/test_geo_shape/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
    "location":{
        "type":"polygon",
        "coordinates":[
            [
                [100,0],[101,0],[101,1],[100,1],[100.0]
            ]
        ]
    }
}'
echo '索引一个四边形,WKT'
curl -X POST 'localhost:9200/test_geo_shape/_doc?pretty&refresh' -H 'content-type:application/json' -d '{
    "location": "POLYGON ((100.0 0.0, 101.0 0.0, 101.0 1.0, 100.0 1.0, 100.0 0.0))"
}'

echo '索引一个multipoint，GeoJSON'
curl -X POST "localhost:9200/test_geo_shape/_doc?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "location" : {
        "type" : "multipoint",
        "coordinates" : [
            [102.0, 2.0], [103.0, 2.0]
        ]
    }
}
'

echo '索引一个multipoint，WKT'
curl -X POST "localhost:9200/test_geo_shape/_doc?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "location" : "MULTIPOINT (102.0 2.0, 103.0 2.0)"
}
'

echo '索引一个multilinestring，GeoJSON'
curl -X POST "localhost:9200/test_geo_shape/_doc?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "location" : {
        "type" : "multilinestring",
        "coordinates" : [
            [ [102.0, 2.0], [103.0, 2.0], [103.0, 3.0], [102.0, 3.0] ],
            [ [100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0] ],
            [ [100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8] ]
        ]
    }
}
'
echo '索引一个multilinestring，WKT'
curl -X POST "localhost:9200/test_geo_shape/_doc?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "location" : "MULTILINESTRING ((102.0 2.0, 103.0 2.0, 103.0 3.0, 102.0 3.0), (100.0 0.0, 101.0 0.0, 101.0 1.0, 100.0 1.0), (100.2 0.2, 100.8 0.2, 100.8 0.8, 100.2 0.8))"
}
'

echo '索引一个multipolygon，GeoJson'
curl -X POST "localhost:9200/test_geo_shape/_doc?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "location" : {
        "type" : "multipolygon",
        "coordinates" : [
            [ [[102.0, 2.0], [103.0, 2.0], [103.0, 3.0], [102.0, 3.0], [102.0, 2.0]] ],
            [ [[100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0]],
              [[100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2]] ]
        ]
    }
}
'

echo '索引一个geometrycollection，GeoJson'
curl -X POST "localhost:9200/test_geo_shape/_doc?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "location" : {
        "type": "geometrycollection",
        "geometries": [
            {
                "type": "point",
                "coordinates": [100.0, 0.0]
            },
            {
                "type": "linestring",
                "coordinates": [ [101.0, 0.0], [102.0, 1.0] ]
            }
        ]
    }
}
'

echo '索引一个边界，GeoJson'
curl -X POST "localhost:9200/test_geo_shape/_doc?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "location" : {
        "type" : "envelope",
        "coordinates" : [ [100.0, 1.0], [101.0, 0.0] ]
    }
}
'


echo '索引一个边界，GeoJson'
curl -X POST "localhost:9200/test_geo_shape/_doc?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "location" : {
        "type" : "envelope",
        "coordinates" : [ [100.0, 1.0], [101.0, 0.0] ]
    }
}
'

echo '索引一个圆，GeoJson'
curl -X POST "localhost:9200/test_geo_shape/_doc?pretty&refresh" -H 'Content-Type: application/json' -d'
{
    "location" : {
        "type" : "circle",
        "coordinates" : [101.0, 1.0],
        "radius" : "100m"
    }
}
'

echo '输出数据'
curl -X GET 'localhost:9200/test_geo_shape/_search?pretty&q=*'