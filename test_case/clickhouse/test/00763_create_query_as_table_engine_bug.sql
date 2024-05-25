select engine from system.tables where database = currentDatabase() and name = 'td';
drop table if exists t;
drop table if exists td;
