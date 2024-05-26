unpivot (select 42 as col1, 'woot' as col2)
    on col1::VARCHAR, col2;
unpivot (select 42 as col1, 'woot' as col2)
    on COLUMNS(*)::VARCHAR;
unpivot (select 42 as col1, 'woot' as col2)
    on (col1 + 100)::VARCHAR, col2;
unpivot (select 42 as col1, 'woot' as col2)
    on (col1 + 100)::VARCHAR AS c, col2;
select * from (select 42 as col1, 'woot' as col2) UNPIVOT ("value" FOR "name" IN (col1::VARCHAR, col2));
