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
