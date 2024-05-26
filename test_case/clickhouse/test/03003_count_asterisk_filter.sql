SELECT count(name) FILTER (WHERE uid > 2000) FROM users;
SELECT countIf(name, uid > 2000) FROM users;
DROP TABLE users;
