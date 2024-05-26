SET allow_experimental_analyzer=1;
create view alias (dummy int, n alias dummy) as select * from system.one;
