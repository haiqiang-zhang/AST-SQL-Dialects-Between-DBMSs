CREATE TABLE user_logins(id serial, who text);
GRANT SELECT ON user_logins TO public;
SELECT COUNT(*) FROM user_logins;
DROP TABLE user_logins;
