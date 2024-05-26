SELECT json_object('ex','[52,3.14159]');
SELECT json(jsonb_object('ex','[52,3.14159]'));
SELECT json_array(1,2,'3',4);
SELECT json_array_length('[1,2,3,4]');
SELECT json_extract('{"a":2,"c":[4,5,{"f":7}]}', '$');
SELECT jsonb_extract('{"a":2,"c":[4,5,{"f":7}]}', '$.c[2].f');
SELECT json_insert('{"a":2,"c":4}', '$.a', 99);
SELECT json_replace('{"a":2,"c":4}', '$.a', 99);
SELECT json_set('{"a":2,"c":4}', '$.a', 99);
SELECT json_remove('[0,1,2,3,4]','$[2]');
SELECT json_type('{"a":[2,3.5,true,false,null,"x"]}');
SELECT json_valid(char(123)||'"x":35'||char(125));
CREATE TABLE user(name,phone,phoneb);
INSERT INTO user(name,phone) VALUES
     ('Alice','["919-555-2345","804-555-3621"]'),
     ('Bob','["201-555-8872"]'),
     ('Cindy','["704-555-9983"]'),
     ('Dave','["336-555-8421","704-555-4321","803-911-4421"]');
UPDATE user SET phoneb=jsonb(phone);
SELECT DISTINCT user.name
    FROM user, json_each(user.phone)
   WHERE json_each.value LIKE '704-%'
   ORDER BY 1;
UPDATE user
     SET phone=json_extract(phone,'$[0]')
   WHERE json_array_length(phone)<2;
SELECT name, substr(phone,1,5) FROM user ORDER BY name;
CREATE TABLE big(json JSON);
INSERT INTO big(json) VALUES('{
    "id":123,
    "stuff":[1,2,3,4],
    "partlist":[
       {"uuid":"bb108722-572e-11e5-9320-7f3b63a4ca74"},
       {"uuid":"c690dc14-572e-11e5-95f9-dfc8861fd535"},
       {"subassembly":[
          {"uuid":"6fa5181e-5721-11e5-a04e-57f3d7b32808"}
       ]}
    ]
  }');
INSERT INTO big(json) VALUES('{
    "id":456,
    "stuff":["hello","world","xyzzy"],
    "partlist":[
       {"uuid":false},
       {"uuid":"c690dc14-572e-11e5-95f9-dfc8861fd535"}
    ]
  }');
SELECT big.rowid, fullkey, value
    FROM big, json_tree(big.json)
   WHERE json_tree.type NOT IN ('object','array')
   ORDER BY +big.rowid, +json_tree.id;
SELECT DISTINCT json_extract(big.json,'$.id')
    FROM big, json_tree(big.json,'$.partlist')
   WHERE json_tree.key='uuid'
     AND json_tree.value='6fa5181e-5721-11e5-a04e-57f3d7b32808';
SELECT json_valid('{"x":01}'), NOT json_error_position('{"x":01}');
WITH RECURSIVE c(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM c WHERE x<0x20)
  SELECT x FROM c WHERE json_valid(printf('{"a":"x%sz"}', char(x))) ORDER BY x;
WITH RECURSIVE c(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM c WHERE x<0x1f)
  SELECT sum(json_valid(json_quote('a'||char(x)||'z'))) FROM c ORDER BY x;
CREATE TABLE t1(id INTEGER PRIMARY KEY, x JSON);
INSERT INTO t1(id,x) VALUES
   (1, '{"a":null}'),
   (2, '{"a":123}'),
   (3, '{"a":4.5}'),
   (4, '{"a":"six"}'),
   (5, '{"a":[7,8]}'),
   (6, '{"a":{"b":9}}'),
   (7, '{"b":999}');
SELECT
    id,
    x->'a' AS '->',
    CASE WHEN subtype(x->'a') THEN 'json' ELSE typeof(x->'a') END AS 'type',
    x->>'a' AS '->>',
    CASE WHEN subtype(x->>'a') THEN 'json' ELSE typeof(x->>'a') END AS 'type',
    json_extract(x,'$.a') AS 'json_extract',
    CASE WHEN subtype(json_extract(x,'$.a'))
         THEN 'json' ELSE typeof(json_extract(x,'$.a')) END AS 'type'
    FROM t1 ORDER BY id;
DELETE FROM t1;
INSERT INTO t1(x) VALUES('[null,123,4.5,"six",[7,8],{"b":9}]');
WITH c(y) AS (VALUES(0),(1),(2),(3),(4),(5),(6))
  SELECT
    y,
    x->y AS '->',
    CASE WHEN subtype(x->y) THEN 'json' ELSE typeof(x->y) END AS 'type',
    x->>y AS '->>',
    CASE WHEN subtype(x->>y) THEN 'json' ELSE typeof(x->>y) END AS 'type',
    json_extract(x,format('$[%d]',y)) AS 'json_extract',
    CASE WHEN subtype(json_extract(x,format('$[%d]',y)))
      THEN 'json' ELSE typeof(json_extract(x,format('$[%d]',y))) END AS 'type'
  FROM c, t1 ORDER BY y;
PRAGMA integrity_check;
SELECT * FROM t1;
PRAGMA integrity_check;
SELECT * FROM t1;
