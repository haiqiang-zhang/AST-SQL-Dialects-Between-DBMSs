CREATE TEMP VIEW vx AS SELECT x, y, 0 AS yy FROM x;
SELECT * FROM vx;
SELECT * FROM vx;
UPDATE x SET y=y+1;
CREATE TABLE t2(a INTEGER PRIMARY KEY, b);
INSERT INTO t2 VALUES(1,2);
CREATE TABLE changes(x,y);
UPDATE t2 SET a=a+10;
SELECT * FROM changes;
DELETE FROM t2;
CREATE TABLE t3(
       c0,  c1,  c2,  c3,  c4,  c5,  c6,  c7,  c8,  c9,
       c10, c11, c12, c13, c14, c15, c16, c17, c18, c19,
       c20, c21, c22, c23, c24, c25, c26, c27, c28, c29,
       c30, c31, c32, c33, c34, c35, c36, c37, c38, c39,
       c40, c41, c42, c43, c44, c45, c46, c47, c48, c49,
       c50, c51, c52, c53, c54, c55, c56, c57, c58, c59,
       c60, c61, c62, c63, c64, c65
    );
CREATE TABLE t3_changes(colnum, oldval, newval);
INSERT INTO t3 VALUES(
       'a0', 'a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9',
       'a10','a11','a12','a13','a14','a15','a16','a17','a18','a19',
       'a20','a21','a22','a23','a24','a25','a26','a27','a28','a29',
       'a30','a31','a32','a33','a34','a35','a36','a37','a38','a39',
       'a40','a41','a42','a43','a44','a45','a46','a47','a48','a49',
       'a50','a51','a52','a53','a54','a55','a56','a57','a58','a59',
       'a60','a61','a62','a63','a64','a65'
    );
SELECT * FROM t3_changes;
UPDATE t3 SET c0='b0';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=0;
UPDATE t3 SET c1='b1';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=1;
UPDATE t3 SET c2='b2';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=2;
UPDATE t3 SET c3='b3';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=3;
UPDATE t3 SET c4='b4';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=4;
UPDATE t3 SET c5='b5';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=5;
UPDATE t3 SET c6='b6';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=6;
UPDATE t3 SET c7='b7';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=7;
UPDATE t3 SET c8='b8';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=8;
UPDATE t3 SET c9='b9';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=9;
UPDATE t3 SET c10='b10';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=10;
UPDATE t3 SET c11='b11';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=11;
UPDATE t3 SET c12='b12';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=12;
UPDATE t3 SET c13='b13';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=13;
UPDATE t3 SET c14='b14';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=14;
UPDATE t3 SET c15='b15';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=15;
UPDATE t3 SET c16='b16';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=16;
UPDATE t3 SET c17='b17';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=17;
UPDATE t3 SET c18='b18';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=18;
UPDATE t3 SET c19='b19';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=19;
UPDATE t3 SET c20='b20';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=20;
UPDATE t3 SET c21='b21';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=21;
UPDATE t3 SET c22='b22';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=22;
UPDATE t3 SET c23='b23';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=23;
UPDATE t3 SET c24='b24';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=24;
UPDATE t3 SET c25='b25';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=25;
UPDATE t3 SET c26='b26';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=26;
UPDATE t3 SET c27='b27';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=27;
UPDATE t3 SET c28='b28';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=28;
UPDATE t3 SET c29='b29';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=29;
UPDATE t3 SET c30='b30';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=30;
UPDATE t3 SET c31='b31';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=31;
UPDATE t3 SET c32='b32';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=32;
UPDATE t3 SET c33='b33';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=33;
UPDATE t3 SET c34='b34';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=34;
UPDATE t3 SET c35='b35';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=35;
UPDATE t3 SET c36='b36';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=36;
UPDATE t3 SET c37='b37';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=37;
UPDATE t3 SET c38='b38';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=38;
UPDATE t3 SET c39='b39';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=39;
UPDATE t3 SET c40='b40';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=40;
UPDATE t3 SET c41='b41';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=41;
UPDATE t3 SET c42='b42';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=42;
UPDATE t3 SET c43='b43';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=43;
UPDATE t3 SET c44='b44';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=44;
UPDATE t3 SET c45='b45';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=45;
UPDATE t3 SET c46='b46';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=46;
UPDATE t3 SET c47='b47';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=47;
UPDATE t3 SET c48='b48';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=48;
UPDATE t3 SET c49='b49';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=49;
UPDATE t3 SET c50='b50';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=50;
UPDATE t3 SET c51='b51';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=51;
UPDATE t3 SET c52='b52';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=52;
UPDATE t3 SET c53='b53';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=53;
UPDATE t3 SET c54='b54';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=54;
UPDATE t3 SET c55='b55';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=55;
UPDATE t3 SET c56='b56';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=56;
UPDATE t3 SET c57='b57';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=57;
UPDATE t3 SET c58='b58';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=58;
UPDATE t3 SET c59='b59';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=59;
UPDATE t3 SET c60='b60';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=60;
UPDATE t3 SET c61='b61';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=61;
UPDATE t3 SET c62='b62';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=62;
UPDATE t3 SET c63='b63';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=63;
UPDATE t3 SET c64='b64';
SELECT * FROM t3_changes ORDER BY rowid DESC LIMIT 1;
SELECT count(*) FROM t3_changes;
SELECT * FROM t3_changes WHERE colnum=64;
