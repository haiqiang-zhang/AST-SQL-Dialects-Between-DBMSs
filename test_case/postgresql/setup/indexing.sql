create table idxpart (a int, b int, c text) partition by range (a);
create index idxpart_idx on idxpart (a);
