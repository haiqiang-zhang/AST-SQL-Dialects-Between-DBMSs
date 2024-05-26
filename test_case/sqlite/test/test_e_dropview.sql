SELECT * FROM sqlite_master WHERE name = 'new view';
DROP VIEW "new view";
SELECT * FROM sqlite_master WHERE name = 'new view';
DROP VIEW IF EXISTS xx;
DROP VIEW IF EXISTS main.xx;
DROP VIEW IF EXISTS temp.v2;
