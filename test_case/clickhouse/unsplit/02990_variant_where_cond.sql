set allow_experimental_variant_type=1;
create table test (v Variant(String, UInt64)) engine=Memory;
insert into test values (42), ('Hello'), (NULL);
drop table test;
