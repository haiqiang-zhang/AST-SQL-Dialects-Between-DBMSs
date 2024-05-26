DROP TABLE IF EXISTS index;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE index
(
    key Int32,
    name String,
    merge_date Date
) ENGINE = MergeTree(merge_date, key, 8192);
insert into index values (1,'1','2016-07-07');
insert into index values (-1,'-1','2016-07-07');
