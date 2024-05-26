SELECT extractValue(@xml,'/a');
select UpdateXML('<a>a1<b>b1<c>c1</c>b2</b>a2</a>','/a/b/c','+++++++++');
select updatexml('<div><div><span>1</span><span>2</span></div></div>',
                 '/','<tr><td>1</td><td>2</td></tr>') as upd1;
select updatexml('', '/', '') as upd2;
select extractvalue(@xml,'order/clerk');
select ExtractValue('<tag1><![CDATA[test]]></tag1>','/tag1');
DROP PROCEDURE IF EXISTS p2;
select updatexml(NULL, 1, 1), updatexml(1, NULL, 1), updatexml(1, 1, NULL);
CREATE TABLE t1(a INT NOT NULL);
INSERT INTO t1 VALUES (0), (0);
SELECT 1 FROM t1 ORDER BY(UPDATEXML(a, '1', '1'));
DROP TABLE t1;
CREATE TABLE IF NOT EXISTS t1 (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  xml text,
  PRIMARY KEY (id)
);
INSERT INTO t1 (id, xml) VALUES
(15, '<?xml version="1.0"?><bla name="blubb"></bla>'),
(14, '<xml version="kaputt">');
DROP TABLE t1;
SELECT REPLACE(EXTRACTVALUE('1', '/a'),'ds','');
SELECT AVG(DISTINCT EXTRACTVALUE((''),('$@k')));
SELECT UPDATEXML(CONVERT(_latin1'<' USING utf8mb3),'1','1');
select @y;
