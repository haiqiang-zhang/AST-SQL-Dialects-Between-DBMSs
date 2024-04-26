
--
-- MyISAM has limits imposed by the server

let $colnum= 4095;
let $str= c text;
{
  let $str= c$colnum int, $str;
  dec $colnum;
ALTER TABLE t1 ADD COLUMN too_much int;
DROP TABLE t1;

let $str= c4096 int, $str;

--
-- MyISAM has limits imposed by the server

let $colnum= 4095;
let $str= c4096 ENUM('a');
{
  let $str= c$colnum ENUM('a$colnum'), $str;
  dec $colnum;
ALTER TABLE t1 ADD COLUMN too_much ENUM('a9999');
DROP TABLE t1;

let $str= $str, too_much ENUM('a9999');

--
--# MyISAM has limits imposed by the server
--

let $colnum= 4095;
let $str= c4096 SET('a');
{
  let $str= c$colnum SET('a$colnum'), $str;
  dec $colnum;
ALTER TABLE t1 ADD COLUMN too_much SET('a9999');
DROP TABLE t1;

let $str= $str, too_much SET('a9999');
