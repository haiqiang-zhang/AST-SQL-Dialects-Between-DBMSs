SELECT
    column,
    subcolumns.names AS sname,
    subcolumns.types AS stype,
    subcolumns.bytes_on_disk > 0
FROM system.parts_columns ARRAY JOIN subcolumns
WHERE database = currentDatabase() AND table = 't_subcolumns_sizes' AND active
ORDER BY column, sname, stype;
SELECT
    any(column_bytes_on_disk) = sum(subcolumns.bytes_on_disk),
    any(column_data_compressed_bytes) = sum(subcolumns.data_compressed_bytes),
    any(column_data_uncompressed_bytes) = sum(subcolumns.data_uncompressed_bytes),
    any(column_marks_bytes) = sum(subcolumns.marks_bytes)
FROM system.parts_columns ARRAY JOIN subcolumns
WHERE database = currentDatabase() AND table = 't_subcolumns_sizes'
AND active AND column = 'd';
DROP TABLE IF EXISTS t_subcolumns_sizes;
