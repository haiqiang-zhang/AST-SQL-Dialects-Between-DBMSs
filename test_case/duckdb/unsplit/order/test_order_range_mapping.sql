pragma enable_verification;
create table test (i hugeint);
insert into test values (295147905179352825856), (73786976294838206464), (147573952589676412928), (36893488147419103232);
drop table test;
