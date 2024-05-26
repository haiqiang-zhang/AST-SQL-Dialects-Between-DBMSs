select amname, prop, pg_indexam_has_property(a.oid, prop) as p
  from pg_am a,
       unnest(array['can_order', 'can_unique', 'can_multi_col',
                    'can_exclude', 'can_include', 'bogus']::text[])
         with ordinality as u(prop,ord)
 where amtype = 'i'
 order by amname, ord;
CREATE TEMP TABLE foo (f1 int, f2 int, f3 int, f4 int);
CREATE INDEX fooindex ON foo (f1 desc, f2 asc, f3 nulls first, f4 nulls last);
select col, prop, pg_index_column_has_property(o, col, prop)
  from (values ('fooindex'::regclass)) v1(o),
       (values (1,'orderable'),(2,'asc'),(3,'desc'),
               (4,'nulls_first'),(5,'nulls_last'),
               (6, 'bogus')) v2(idx,prop),
       generate_series(1,4) col
 order by col, idx;
CREATE INDEX foocover ON foo (f1) INCLUDE (f2,f3);
