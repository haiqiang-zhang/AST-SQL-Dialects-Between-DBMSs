SELECT CONCAT(Jahr,'-',Monat,'-',Tag,' ',Zeit) AS Date,
   UNIX_TIMESTAMP(CONCAT(Jahr,'-',Monat,'-',Tag,' ',Zeit)) AS Unix
FROM t1;
drop table t1;
