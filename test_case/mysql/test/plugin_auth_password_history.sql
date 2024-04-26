CREATE USER pwd_history_plugin@localhost IDENTIFIED WITH 'test_plugin_server' PASSWORD HISTORY 1;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='pwd_history_plugin' AND Host='localhost';
ALTER USER pwd_history_plugin@localhost IDENTIFIED WITH 'test_plugin_server' PASSWORD REUSE INTERVAL 1 DAY;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='pwd_history_plugin' AND Host='localhost';

DROP USER pwd_history_plugin@localhost;

CREATE USER mohit@localhost IDENTIFIED BY 'mohit_native' PASSWORD HISTORY 1;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='mohit' AND Host='localhost';

ALTER USER mohit@localhost IDENTIFIED WITH 'test_plugin_server' AS 'haha';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='mohit' AND Host='localhost';

DROP USER mohit@localhost;
