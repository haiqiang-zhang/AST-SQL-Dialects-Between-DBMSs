CREATE TABLE t1 (`a` INT, `b` INT, `C` INT,
                 `D` INT, `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡` INT, `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©` INT,
                 `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` INT, `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` INT, `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂª` INT,
                 KEY `a` ( `a` ), KEY `b` ( `b` ), KEY `C` ( `C` ),
                 KEY `D` ( `D` ), KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡` ), KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©` ),
                 KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` ), KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` ), KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂª` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂª` ));
CREATE TABLE t2 (`ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂª` INT, `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` INT, `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` INT,
                 `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©` INT, `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡` INT, `D` INT,
                 `C` INT, `b` INT, `a` INT,
                 KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂª` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂª` ), KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` ), KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ` ),
                 KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©` ), KEY `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡` ( `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡` ), KEY `D` ( `D` ),
                 KEY `C` ( `C` ), KEY `b` ( `b` ), KEY `a` ( `a` ));
SELECT table_name, column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name= 't1' ORDER BY column_name;
SELECT table_name, column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name= 't2' ORDER BY column_name;
SELECT table_name, index_name, column_name FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME= 't1' ORDER BY index_name;
SELECT table_name, index_name, column_name FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME= 't2' ORDER BY index_name;
DROP TABLE t2, t1;
