
-- Save timestamp to restore tables
--let $PWCHANGED= `SELECT password_last_changed FROM mysql.user WHERE user LIKE 'mysql.sys';
DROP TABLE mysql.component;
SELECT COUNT(*) FROM mysql.component;
