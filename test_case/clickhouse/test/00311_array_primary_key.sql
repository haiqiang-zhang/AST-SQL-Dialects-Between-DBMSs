SELECT * FROM array_pk ORDER BY n;
DETACH TABLE array_pk;
ATTACH TABLE array_pk;
SELECT * FROM array_pk ORDER BY n;
DROP TABLE array_pk;
