
-- Bug#31293 - Incorrect parser errors for create/alter/drop logfile group/tablespace
--

-- error ER_ILLEGAL_HA_CREATE_OPTION
create logfile group ndb_lg1 add undofile 'ndb_undo1.dat' initial_size=32M engine=myisam;
create logfile group ndb_lg1 add undofile 'ndb_undo1.dat' engine=myisam;
create logfile group ndb_lg1 add undofile 'ndb_undo1.dat';

-- error ER_ILLEGAL_HA_CREATE_OPTION
create tablespace ndb_ts1 add datafile 'ndb_ts1.dat' use logfile group ndb_lg1 engine=myisam initial_size=32M;
create tablespace ndb_ts1 add datafile 'ndb_ts1.dat' use logfile group ndb_lg1 engine=myisam;
create tablespace ndb_ts1 add datafile 'ndb_ts1.dat' use logfile group ndb_lg1 engine=myisam;

-- error ER_ILLEGAL_HA_CREATE_OPTION
alter logfile group ndb_lg1 add undofile 'ndb_undo1.dat' wait engine=myisam;
alter logfile group ndb_lg1 add undofile 'ndb_undo1.dat' engine=myisam;
alter logfile group ndb_lg1 add undofile 'ndb_undo1.dat' engine=myisam;

-- error ER_TABLESPACE_MISSING_WITH_NAME
alter tablespace ndb_ts1 add datafile 'ndb_ts1.dat' initial_size=32M engine=myisam;
alter tablespace ndb_ts1 add datafile 'ndb_ts1.dat' engine=myisam;
alter tablespace ndb_ts1 add datafile 'ndb_ts1.dat' engine=myisam;

-- error ER_ILLEGAL_HA_CREATE_OPTION
drop logfile group ndb_lg1 engine=myisam;
drop logfile group ndb_lg1 engine=myisam;

-- error ER_TABLESPACE_MISSING_WITH_NAME
drop tablespace ndb_ts1 engine=myisam;
drop tablespace ndb_ts1 engine=myisam;
