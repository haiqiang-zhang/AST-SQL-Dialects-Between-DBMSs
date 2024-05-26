SELECT name, engine, engine_full, create_table_query, data_paths, notEmpty([metadata_path]), notEmpty([uuid])
    FROM system.tables
    WHERE name like '%tablefunc%' and database=currentDatabase()
    ORDER BY name;
