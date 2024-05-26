SELECT json_array(1,2.5,null,'hello');
SELECT hex(json_array('String "\ Test'));
SELECT json(jsonb_array(-9223372036854775808,9223372036854775807,0,1,-1,
                    0.0, 1.0, -1.0, -1e99, +2e100,
                    'one','two','three',
                    4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
                    19, NULL, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
                    'abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZ',
                    'abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZ',
                    'abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZ',
                    99));
SELECT json_object('a',1,'b',2.5,'c',null,'d','String Test');
SELECT json_replace('{"a":1,"b":2}','$.a','[3,4,5]');
SELECT json_type(json_set('{"a":1,"b":2}','$.b','{"x":3,"y":4}'),'$.b');
SELECT fullkey, atom, '|' FROM json_tree(json_set('{}','$.x',123,'$.x',456));
CREATE TABLE j1(x);
INSERT INTO j1(x)
   VALUES('true'),('false'),('null'),('123'),('-234'),('34.5e+6'),
         ('""'),('"\""'),('"\\"'),('"abcdefghijlmnopqrstuvwxyz"'),
         ('[]'),('{}'),('[true,false,null,123,-234,34.5e+6,{},[]]'),
         ('{"a":true,"b":{"c":false}}');
SELECT * FROM j1 WHERE NOT json_valid(x);
SELECT * FROM j1 WHERE NOT json_valid(char(0x20,0x09,0x0a,0x0d)||x);
SELECT * FROM j1 WHERE NOT json_valid(x||char(0x20,0x09,0x0a,0x0d));
SELECT json_valid(''), json_valid(char(0x20,0x09,0x0a,0x0d));
SELECT x FROM j1 WHERE json_remove(x)<>x;
SELECT x FROM j1 WHERE json_replace(x)<>x;
SELECT x FROM j1 WHERE json_set(x)<>x;
SELECT x FROM j1 WHERE json_insert(x)<>x;
SELECT json_insert('{"a":1}','$.b',CAST(x'0000' AS text));
SELECT count(*) FROM j1 WHERE json_type(x) IN ('object','array');
SELECT x FROM j1
   WHERE json_extract(x,'$')<>x
     AND json_type(x) IN ('object','array');
CREATE TABLE j1b AS SELECT jsonb(x) AS "x" FROM j1;
CREATE TABLE j2(id INTEGER PRIMARY KEY, json, src);
INSERT INTO j2(id,json,src)
  VALUES(1,'{
    "firstName": "John",
    "lastName": "Smith",
    "isAlive": true,
    "age": 25,
    "address": {
      "streetAddress": "21 2nd Street",
      "city": "New York",
      "state": "NY",
      "postalCode": "10021-3100"
    },
    "phoneNumbers": [
      {
        "type": "home",
        "number": "212 555-1234"
      },
      {
        "type": "office",
        "number": "646 555-4567"
      }
    ],
    "children": [],
    "spouse": null
  }','https://en.wikipedia.org/wiki/JSON');
INSERT INTO j2(id,json,src)
  VALUES(2, '{
	"id": "0001",
	"type": "donut",
	"name": "Cake",
	"ppu": 0.55,
	"batters":
		{
			"batter":
				[
					{ "id": "1001", "type": "Regular" },
					{ "id": "1002", "type": "Chocolate" },
					{ "id": "1003", "type": "Blueberry" },
					{ "id": "1004", "type": "Devil''s Food" }
				]
		},
	"topping":
		[
			{ "id": "5001", "type": "None" },
			{ "id": "5002", "type": "Glazed" },
			{ "id": "5005", "type": "Sugar" },
			{ "id": "5007", "type": "Powdered Sugar" },
			{ "id": "5006", "type": "Chocolate with Sprinkles" },
			{ "id": "5003", "type": "Chocolate" },
			{ "id": "5004", "type": "Maple" }
		]
   }','https://adobe.github.io/Spry/samples/data_region/JSONDataSetSample.html');
INSERT INTO j2(id,json,src)
   VALUES(3,'[
	{
		"id": "0001",
		"type": "donut",
		"name": "Cake",
		"ppu": 0.55,
		"batters":
			{
				"batter":
					[
						{ "id": "1001", "type": "Regular" },
						{ "id": "1002", "type": "Chocolate" },
						{ "id": "1003", "type": "Blueberry" },
						{ "id": "1004", "type": "Devil''s Food" }
					]
			},
		"topping":
			[
				{ "id": "5001", "type": "None" },
				{ "id": "5002", "type": "Glazed" },
				{ "id": "5005", "type": "Sugar" },
				{ "id": "5007", "type": "Powdered Sugar" },
				{ "id": "5006", "type": "Chocolate with Sprinkles" },
				{ "id": "5003", "type": "Chocolate" },
				{ "id": "5004", "type": "Maple" }
			]
	},
	{
		"id": "0002",
		"type": "donut",
		"name": "Raised",
		"ppu": 0.55,
		"batters":
			{
				"batter":
					[
						{ "id": "1001", "type": "Regular" }
					]
			},
		"topping":
			[
				{ "id": "5001", "type": "None" },
				{ "id": "5002", "type": "Glazed" },
				{ "id": "5005", "type": "Sugar" },
				{ "id": "5003", "type": "Chocolate" },
				{ "id": "5004", "type": "Maple" }
			]
	},
	{
		"id": "0003",
		"type": "donut",
		"name": "Old Fashioned",
		"ppu": 0.55,
		"batters":
			{
				"batter":
					[
						{ "id": "1001", "type": "Regular" },
						{ "id": "1002", "type": "Chocolate" }
					]
			},
		"topping":
			[
				{ "id": "5001", "type": "None" },
				{ "id": "5002", "type": "Glazed" },
				{ "id": "5003", "type": "Chocolate" },
				{ "id": "5004", "type": "Maple" }
			]
	}
   ]','https://adobe.github.io/Spry/samples/data_region/JSONDataSetSample.html');
CREATE TABLE j2b(id INTEGER PRIMARY KEY, json, src);
INSERT INTO J2b(id,json,src) SELECT id, jsonb(json), src FROM j2;
SELECT id, json_valid(json), json_type(json), '|' FROM j2 ORDER BY id;
SELECT j2.rowid, jx.rowid, fullkey, path, key
    FROM j2, json_tree(j2.json) AS jx
   WHERE fullkey!=(path || CASE WHEN typeof(key)=='integer' THEN '['||key||']'
                                ELSE '.'||key END);
SELECT j2b.rowid, jx.rowid, fullkey, path, key
    FROM j2b, json_tree(j2b.json) AS jx
   WHERE fullkey!=(path || CASE WHEN typeof(key)=='integer' THEN '['||key||']'
                                ELSE '.'||key END);
SELECT j2.rowid, jx.rowid, fullkey, path, key
    FROM j2, json_each(j2.json) AS jx
   WHERE fullkey!=(path || CASE WHEN typeof(key)=='integer' THEN '['||key||']'
                                ELSE '.'||key END);
SELECT j2.rowid, jx.rowid, fullkey, path, key
    FROM j2, json_each(j2.json) AS jx
   WHERE jx.json<>j2.json;
SELECT j2.rowid, jx.rowid, fullkey, path, key
    FROM j2, json_tree(j2.json) AS jx
   WHERE jx.json<>j2.json;
SELECT j2.rowid, jx.rowid, fullkey, path, key
    FROM j2, json_each(j2.json) AS jx
   WHERE jx.value<>jx.atom AND type NOT IN ('array','object');
SELECT j2.rowid, jx.rowid, fullkey, path, key
    FROM j2, json_tree(j2.json) AS jx
   WHERE jx.value<>jx.atom AND type NOT IN ('array','object');
SELECT json_insert('{}','$.a',value) FROM json_tree('[1,2,3]') WHERE atom IS NULL;
SELECT json_error_position('{"a":55,"b":72,}');
DROP TABLE IF EXISTS t8;
CREATE TABLE t8(a,b);
INSERT INTO t8(a) VALUES('abc' || char(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35) || 'xyz');
UPDATE t8 SET b=json_array(a);
SELECT b FROM t8;
DROP TABLE IF EXISTS t8;
CREATE TABLE t8(a,b);
INSERT INTO t8(a) VALUES('abc' || char(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35) || 'xyz');
UPDATE t8 SET b=jsonb_array(a);
SELECT a=json_extract(b,'$[0]') FROM t8;
SELECT unicode(json_extract(char(0x22,228,0x22),'$'));
SELECT json_quote('abc"xyz');
CREATE TABLE t12(x);
INSERT INTO t12(x) VALUES(
    '{"settings":
        {"layer2":
           {"hapax.legomenon":
              {"forceDisplay":true,
               "transliterate":true,
               "add.footnote":true,
               "summary.report":true},
            "dis.legomenon":
              {"forceDisplay":true,
               "transliterate":false,
               "add.footnote":false,
               "summary.report":true},
            "tris.legomenon":
              {"forceDisplay":true,
               "transliterate":false,
               "add.footnote":false,
               "summary.report":false}
           }
        }
     }');
SELECT json_remove(x, '$.settings.layer2."dis.legomenon".forceDisplay')
    FROM t12;
SELECT json_extract(x, '$.settings.layer2."tris.legomenon"."summary.report"')
    FROM t12;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1(id, json);
INSERT INTO t1(id,json) VALUES(1,'{"items":[3,5]}');
CREATE TABLE t2(id, json);
INSERT INTO t2(id,json) VALUES(2,'{"value":2}');
INSERT INTO t2(id,json) VALUES(3,'{"value":3}');
INSERT INTO t2(id,json) VALUES(4,'{"value":4}');
INSERT INTO t2(id,json) VALUES(5,'{"value":5}');
INSERT INTO t2(id,json) VALUES(6,'{"value":6}');
SELECT * FROM t1 CROSS JOIN t2
   WHERE EXISTS(SELECT 1 FROM json_each(t1.json,'$.items') AS Z
                 WHERE Z.value==t2.id);
SELECT * FROM t2 CROSS JOIN t1
   WHERE EXISTS(SELECT 1 FROM json_each(t1.json,'$.items') AS Z
                 WHERE Z.value==t2.id);
SELECT fullkey FROM json_each('123');
SELECT * FROM JSON_EACH('{"a":1, "b":2}');
SELECT xyz.* FROM JSON_EACH('{"a":1, "b":2}') AS xyz;
SELECT * FROM (JSON_EACH('{"a":1, "b":2}'));
SELECT xyz.* FROM (JSON_EACH('{"a":1, "b":2}')) AS xyz;
SELECT length(json_extract('"abc\uD834\uDD1Exyz"','$'));
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1(a,b,c);
CREATE TABLE t2(d);
SELECT * FROM t1 LEFT JOIN t2 ON (SELECT b FROM json_each ORDER BY 1);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(x);
BEGIN;
SELECT * FROM t1;
SELECT json_object('a',2e370,'b',-3e380)->>'a';
SELECT json_object('a',2e370,'b',-3e380)->>'b';
SELECT NULL->0;
SELECT NULL->>0;
SELECT '{a:5}'->NULL;
SELECT '{a:5}'->>NULL;
SELECT json_patch(NULL,'{a:5}');
SELECT json_set(NULL,'$.a',123);
SELECT count(*) FROM json_each(NULL);
SELECT count(*) FROM json_tree(NULL);
WITH c(x) AS (VALUES(1),(2.0),(NULL),('three'))
  SELECT json_group_array(x) FROM c;
WITH c(x,y) AS (VALUES('a',1),('b',2.0),('c',NULL),(NULL,'three'),('e','four'))
  SELECT json_group_object(x,y) FROM c;
SELECT j, j->>0, j->>1
    FROM (SELECT json_set(json_set('[]','$[#]',0), '$[#]',1) AS j);
SELECT j, j->>0, j->>1
    FROM (SELECT json_set('[]','$[#]',0,'$[#]',1) AS j);
