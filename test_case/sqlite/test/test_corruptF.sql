PRAGMA auto_vacuum = 0;
PRAGMA page_size = 1024;
CREATE TABLE t1(x);
/* root page = 2 */
    CREATE TABLE t2(x);
/* root page = 3 */
    CREATE TABLE t3(x);
DROP TABLE t2;
DROP TABLE t3;
CREATE TABLE t4(x);
SELECT * FROM sqlite_master;
PRAGMA auto_vacuum = 0;
PRAGMA page_size = 1024;
/* root page = 2 */
    CREATE TABLE t2(x);
/* root page = 3 */
    CREATE TABLE t3(x);
DROP TABLE t2;
DROP TABLE t3;
SELECT * FROM sqlite_master;
