PRAGMA enable_verification;
unpivot (select cast(columns(*) as varchar) from (select 42 as col1, 'woot' as col2))
    on columns(*);
