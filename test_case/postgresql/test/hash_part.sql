create table text_hashp (a text) partition by hash (a);
create table text_hashp0 partition of text_hashp for values with (modulus 2, remainder 0);
create table text_hashp1 partition of text_hashp for values with (modulus 2, remainder 1);
select satisfies_hash_partition('text_hashp'::regclass, 2, 0, 'xxx'::text) OR
	   satisfies_hash_partition('text_hashp'::regclass, 2, 1, 'xxx'::text) AS satisfies;
DROP TABLE text_hashp;
