create table text_hashp (a text) partition by hash (a);
create table text_hashp0 partition of text_hashp for values with (modulus 2, remainder 0);
create table text_hashp1 partition of text_hashp for values with (modulus 2, remainder 1);
