alter table alias_column_should_not_allow_compression modify column user_id codec(LZ4HC(1));
drop table if exists alias_column_should_not_allow_compression;
