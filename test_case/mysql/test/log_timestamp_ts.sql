SELECT SUBSTRING(@my_time, 2, LENGTH(@my_time)-2) INTO @my_time;
SELECT TRUNCATE(UNIX_TIMESTAMP(@my_time),3) INTO @my_time;
SELECT IF((@my_ts-@my_time)=0,"SUCCESS","FAILURE");
