SELECT 0x0;
SELECT 0x0000000000000000000000000000000000000000000001;
SELECT 0x2;
SELECT 0x4;
SELECT 0x8;
SELECT 0x00000000000000000000000000000000000000000000010;
SELECT 0x20;
SELECT 0x40;
SELECT 0x80;
SELECT 0x100;
SELECT 0x200;
SELECT 0X400;
SELECT 0x800;
SELECT 0x1000;
SELECT 0x2000;
SELECT 0x4000;
SELECT 0x8000;
SELECT 0x10000;
SELECT 0x20000;
SELECT 0x40000;
SELECT 0x80000;
SELECT 0x100000;
SELECT 0x200000;
SELECT 0x400000;
SELECT 0x800000;
SELECT 0x1000000;
SELECT 0x2000000;
SELECT 0x4000000;
SELECT 0x8000000;
SELECT 0x10000000;
SELECT 0x20000000;
SELECT 0x40000000;
SELECT 0x80000000;
SELECT 0x100000000;
SELECT 0x200000000;
SELECT 0x400000000;
SELECT 0x800000000;
SELECT 0x1000000000;
SELECT 0x2000000000;
SELECT 0x4000000000;
SELECT 0x8000000000;
SELECT 0x10000000000;
SELECT 0x20000000000;
SELECT 0x40000000000;
SELECT 0x80000000000;
SELECT 0x100000000000;
SELECT 0x200000000000;
SELECT 0x400000000000;
SELECT 0x800000000000;
SELECT 0x1000000000000;
SELECT 0x2000000000000;
SELECT 0x4000000000000;
SELECT 0x8000000000000;
SELECT 0x10000000000000;
SELECT 0x20000000000000;
SELECT 0x40000000000000;
SELECT 0x80000000000000;
SELECT 0x100000000000000;
SELECT 0x200000000000000;
SELECT 0x400000000000000;
SELECT 0x800000000000000;
SELECT 0X1000000000000000;
SELECT 0x2000000000000000;
SELECT 0X4000000000000000;
SELECT 0x8000000000000000;
SELECT 0XFFFFFFFFFFFFFFFF;
SELECT 0X001;
SELECT 0x001;
SELECT 0X001;
SELECT 0x001;
SELECT 0X002;
SELECT 0x002;
SELECT 0X002;
SELECT 0x002;
SELECT 0X003;
SELECT 0x003;
SELECT 0X003;
SELECT 0x003;
SELECT 0X004;
SELECT 0x004;
SELECT 0X004;
SELECT 0x004;
SELECT 0X005;
SELECT 0x005;
SELECT 0X005;
SELECT 0x005;
SELECT 0X006;
SELECT 0x006;
SELECT 0X006;
SELECT 0x006;
SELECT 0X007;
SELECT 0x007;
SELECT 0X007;
SELECT 0x007;
SELECT 0X008;
SELECT 0x008;
SELECT 0X008;
SELECT 0x008;
SELECT 0X009;
SELECT 0x009;
SELECT 0X009;
SELECT 0x009;
SELECT 0X00A;
SELECT 0x00A;
SELECT 0X00a;
SELECT 0x00a;
SELECT 0X00B;
SELECT 0x00B;
SELECT 0X00b;
SELECT 0x00b;
SELECT 0X00C;
SELECT 0x00C;
SELECT 0X00c;
SELECT 0x00c;
SELECT 0X00D;
SELECT 0x00D;
SELECT 0X00d;
SELECT 0x00d;
SELECT 0X00E;
SELECT 0x00E;
SELECT 0X00e;
SELECT 0x00e;
SELECT 0X00F;
SELECT 0x00F;
SELECT 0X00f;
SELECT 0x00f;
CREATE TABLE t1(x INT, y REAL);
INSERT INTO t1 VALUES('1234','4567'),('0x1234','0x4567');
SELECT typeof(x), x, typeof(y), y, '#' FROM t1 ORDER BY rowid;
SELECT CAST('0x1234' AS INTEGER);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(x);