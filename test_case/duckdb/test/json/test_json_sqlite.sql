SELECT count(*) FROM j1 WHERE json_type(x) IN ('OBJECT','ARRAY');
SELECT x FROM j1
   WHERE json_extract(x,'$')<>x
     AND json_type(x) IN ('OBJECT','ARRAY');
SELECT count(*) FROM j2;
SELECT id, json_valid(json), json_type(json) FROM j2 ORDER BY id;
