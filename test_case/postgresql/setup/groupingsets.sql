create temp view gstest1(a,b,v)
  as values (1,1,10),(1,1,11),(1,2,12),(1,2,13),(1,3,14),
            (2,3,15),
            (3,3,16),(3,4,17),
            (4,1,18),(4,1,19);
create temp table gstest2 (a integer, b integer, c integer, d integer,
                           e integer, f integer, g integer, h integer);
create temp table gstest4(id integer, v integer,
                          unhashable_col bit(4), unsortable_col xid);
insert into gstest4
values (1,1,b'0000','1'), (2,2,b'0001','1'),
       (3,4,b'0010','2'), (4,8,b'0011','2'),
       (5,16,b'0000','2'), (6,32,b'0001','2'),
       (7,64,b'0010','1'), (8,128,b'0011','1');
create temp table gstest_empty (a integer, b integer, v integer);
create function gstest_data(v integer, out a integer, out b integer)
  returns setof record
  as $f$
    begin
      return query select v, i from generate_series(1,3) i;
    end;
  $f$ language plpgsql;
set enable_hashagg = false;
