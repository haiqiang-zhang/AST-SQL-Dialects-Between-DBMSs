
DROP TABLE mysql.role_edges;
DROP TABLE mysql.default_roles;

let server_log= $MYSQLTEST_VARDIR/log/roles-upgrade.err;
let restart_parameters=restart:--log-error=$server_log;
CREATE USER u1;
CREATE ROLE r1;

CREATE USER u1;
CREATE ROLE r1;
CREATE TABLE test.t1(c1 int);
INSERT INTO test.t1 VALUES(1);
SET ROLE r1;
SELECT * from t1;
DROP TABLE test.t1;
DROP ROLE r1;
DROP USER u1;
