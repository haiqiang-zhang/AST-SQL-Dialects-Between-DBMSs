-- https://github.com/ClickHouse/ClickHouse/issues/44039
SET allow_experimental_analyzer=1;
create table test_window_collate(c1 String, c2 String) engine=MergeTree order by c1;
insert into test_window_collate values('1', 'Ã¤Â¸ÂÃ¦ÂµÂ·');
insert into test_window_collate values('1', 'Ã¥ÂÂÃ¤ÂºÂ¬');
insert into test_window_collate values('1', 'Ã¨Â¥Â¿Ã¥Â®Â');
