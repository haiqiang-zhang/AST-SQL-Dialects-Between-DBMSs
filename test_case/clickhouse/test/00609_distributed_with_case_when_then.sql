SELECT CASE x WHEN 1 THEN 'hello' WHEN 2 THEN 'world' ELSE  'unknow' END FROM mergetree_00609;
SELECT count() AS cnt FROM (SELECT CASE x WHEN 1 THEN 'hello' WHEN 2 THEN 'world' ELSE  'unknow' END FROM mergetree_00609);
DROP TABLE mergetree_00609;
