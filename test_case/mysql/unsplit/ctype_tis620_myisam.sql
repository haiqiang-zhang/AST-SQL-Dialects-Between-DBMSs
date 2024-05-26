CREATE TABLE t1 (
  recid int(11) NOT NULL auto_increment,
  dyninfo text,
  PRIMARY KEY  (recid)
) ENGINE=MyISAM CHARACTER SET tis620;
INSERT INTO t1 VALUES (1,'color=\"STB,NPG\"\r\nengine=\"J30A13\"\r\nframe=\"MRHCG1640YP4\"\r\ngrade=\"V6\"\r\nmodel=\"ACCORD\"\r\nmodelcode=\"CG164YEN\"\r\ntype=\"VT6\"\r\n');
INSERT INTO t1 VALUES (2,'color=\"HTM,NPG,DEG,RGS\"\r\nengine=\"F23A5YP1\"\r\nframe=\"MRHCF8640YP3\"\r\ngrade=\"EXi AT\"\r\nmodel=\"ACCORD\"\r\nmodelcode=\"CF864YE\"\r\ntype=\"EXA\"\r\n');
SELECT DISTINCT 
 (IF( LOCATE( 'year=\"', dyninfo ) = 1, 
  SUBSTRING( dyninfo, 6+1, LOCATE('\"\r',dyninfo) - 6 -1), 
  IF( LOCATE( '\nyear=\"', dyninfo ), 
  SUBSTRING( dyninfo, LOCATE( '\nyear=\"', dyninfo ) + 7, 
  LOCATE( '\"\r', SUBSTRING( dyninfo, LOCATE( '\nyear=\"', dyninfo ) +7 )) - 1), '' ))) AS year 
FROM t1
HAVING year != '' ORDER BY year;
DROP TABLE t1;
CREATE TABLE t1
(
  name varchar(50) NOT NULL default '',
  excelorder int(11) NOT NULL default '0',
  neworder int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=tis620;
