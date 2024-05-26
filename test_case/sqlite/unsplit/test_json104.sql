SELECT json_patch('{
       "a": "b",
       "c": {
         "d": "e",
         "f": "g"
       }
     }','{
       "a":"z",
       "c": {
         "f": null
       }
     }');
SELECT coalesce(json_patch(null,'{"a":"c"}'), 'real-null');
CREATE TABLE obj(x);
INSERT INTO obj VALUES('{"a":1,"b":2}');
SELECT * FROM obj;
UPDATE obj SET x = json_insert(x, '$.c', 3);
SELECT * FROM obj;
SELECT json_extract(x, '$.b') FROM obj;
UPDATE obj SET x = json_set(x, '$."b"', 555);
UPDATE obj SET x = json_set(x, '$."d"', 4);
