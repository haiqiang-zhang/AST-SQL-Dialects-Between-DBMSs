CREATE VIEW raw_data_parametrized AS
SELECT *
FROM raw_data
WHERE (id >= {id_from:UInt8}) AND (id <= {id_to:UInt8});
SELECT t1.id
FROM raw_data_parametrized(id_from = 0, id_to = 50000) t1
ORDER BY t1.id;
