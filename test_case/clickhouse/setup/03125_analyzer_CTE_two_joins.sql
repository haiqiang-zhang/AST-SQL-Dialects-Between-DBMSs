SET allow_experimental_analyzer=1;
create table events ( distinct_id String ) engine = Memory;
INSERT INTO events VALUES ('1234'), ('1');
