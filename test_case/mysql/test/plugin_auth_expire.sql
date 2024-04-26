
CREATE USER b22551523@localhost;
SELECT password_expired from mysql.user where user='b22551523' and host = 'localhost';

ALTER USER b22551523@localhost IDENTIFIED with 'test_plugin_server';
SELECT password_expired from mysql.user where user='b22551523' and host = 'localhost';

ALTER USER b22551523@localhost IDENTIFIED with 'mysql_native_password';
SELECT password_expired from mysql.user where user='b22551523' and host = 'localhost';

DROP USER b22551523@localhost;
