select 1+2/*hello*/+3;
select 1 /* long
multi line comment */;
select 1 /*!32301 +1 */;
select 1 /*!999999 +1 */;
select 1--1;
select 1 --2
+1;
select 1 # The rest of the row will be ignored;
select 1/*!999992*/;
select 1 + /*!00000 2 */ + 3 /*!99999 noise*/ + 4;
drop table if exists table_28779;
create table table_28779 (a int);
drop table table_28779;
SELECT 1 /*!99999 /* */ */;
SELECT 2 /*!12345 /* */ */;
SELECT 3 /*! /* */ */;
SELECT 1 + /*!800001+0 */ + 0 AS should_return_2;
SELECT 1 /*!080100	+1*/ AS should_return_2;
SELECT 1 /*!080100
+1*/ AS should_return_2;
SELECT 1 /*!080100+1*/ AS should_return_2;
SELECT 1 /*!080100+1*/ AS should_return_2;
SELECT 1 /*!080100
+1*/ AS should_return_2;
SELECT 1 /*!080100 +1*/ AS should_return_2;
