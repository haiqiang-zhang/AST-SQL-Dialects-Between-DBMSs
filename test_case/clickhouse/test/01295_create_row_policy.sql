SELECT '-- default';
SELECT '-- same as default';
SELECT '-- rename';
SELECT '-- filter';
SELECT '-- to roles';
SELECT '-- multiple policies in one command';
SELECT '-- system.row_policies';
SELECT name, short_name, database, table, storage, select_filter, is_restrictive, apply_to_all, apply_to_list, apply_to_except from system.row_policies WHERE short_name LIKE 'p%\_01295' ORDER BY name;
