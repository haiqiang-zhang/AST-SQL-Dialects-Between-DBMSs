optimize table badFixedStringSort final;
select hex(uuid5_old), subitem from badFixedStringSort ORDER BY  uuid5_old, subitem;
drop table if exists badFixedStringSort;
