
--
-- ls_messages
--
CREATE TABLE t1(f1 INT);
SET lc_messages=ru_RU;
CREATE TABLE t1(f1 INT);
SET NAMES utf8mb3;
CREATE TABLE t1(f1 INT);
CREATE TABLE t1(f1 INT);
SET GLOBAL lc_messages=ru_RU;
SET GLOBAL lc_messages=en_US;
DROP TABLE t1;

--
-- Bug#1406 Tablename in Errormessage not in default characterset
--
--error ER_BAD_TABLE_ERROR
drop table `ק`;

--
-- Bug#14602 Error messages not returned in character_set_results
--
connect (con1,localhost,root,,test);
SET lc_messages=cs_CZ;
SET NAMES utf8mb3;
USE nonexistant;
SET lc_messages=ru_RU;
SET NAMES latin1;
