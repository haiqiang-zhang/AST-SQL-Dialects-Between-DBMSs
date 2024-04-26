--

--source include/not_valgrind.inc
--source include/mysql_upgrade_preparation.inc

let $date_to_restore=`SELECT password_last_changed FROM mysql.user WHERE user='mysql.infoschema'`;

DELETE FROM mysql.user WHERE user='mysql.infoschema';
