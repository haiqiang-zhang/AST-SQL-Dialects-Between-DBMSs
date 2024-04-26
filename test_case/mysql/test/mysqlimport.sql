
CREATE DATABASE b12688860_db;
CREATE TABLE b12688860_db.b12688860_tab (c1 INT);
1
2
3
EOF

--exec $MYSQL_IMPORT -uroot --password="" b12688860_db $MYSQLTEST_VARDIR/tmp/b12688860_tab.sql 2>&1

SELECT * FROM b12688860_db.b12688860_tab;
DROP TABLE b12688860_db.b12688860_tab;
DROP DATABASE b12688860_db;

CREATE USER 'user_with_length_32_abcdefghijkl'@'localhost';
DROP TABLE mysql.test;
DROP USER 'user_with_length_32_abcdefghijkl'@'localhost';

CREATE TABLE mysql.test(a INT PRIMARY KEY);
DROP TABLE mysql.test;

CREATE DATABASE b34999015_db;
CREATE TABLE b34999015_db.`KEY` (`ID` INT NOT NULL, PRIMARY KEY (`ID`));
1
2
3
EOF

--echo -- Test: should succeed
--exec $MYSQL_IMPORT -uroot b34999015_db --local --delete $MYSQLTEST_VARDIR/tmp/KEY.txt 2>&1

echo -- cleanup
DROP TABLE b34999015_db.`KEY`;
DROP DATABASE b34999015_db;
