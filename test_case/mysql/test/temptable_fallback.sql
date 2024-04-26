
-- ---------------------------------------------------------------------
-- Prepare
--

--echo -- Disable sorting by addon fields, as that will enable the
--echo -- StreamingIterator in many of the test cases, resulting in
--echo -- fewer materializations.
SET debug = '+d,filesort_force_sort_row_ids';

CREATE TABLE t (c VARCHAR(128));

INSERT INTO t VALUES
    (REPEAT('a', 128)),
    (REPEAT('b', 128)),
    (REPEAT('c', 128)),
    (REPEAT('d', 128));

SET @@internal_tmp_mem_storage_engine = MEMORY;
SELECT * FROM
    t AS t1,
    t AS t2,
    t AS t3,
    t AS t4,
    t AS t5,
    t AS t6
    ORDER BY 1
    LIMIT 2;

SELECT @@internal_tmp_mem_storage_engine;

SET @@internal_tmp_mem_storage_engine = default;

SET @@internal_tmp_mem_storage_engine = MEMORY;
SET @@max_heap_table_size = 16384;
SELECT * FROM
    t AS t1,
    t AS t2,
    t AS t3,
    t AS t4,
    t AS t5,
    t AS t6
    ORDER BY 1
    LIMIT 2;

SELECT @@internal_tmp_mem_storage_engine;

SET @@internal_tmp_mem_storage_engine = default;
SET @@max_heap_table_size = default;

SET @@internal_tmp_mem_storage_engine = TempTable;
SELECT count_alloc
    FROM performance_schema.memory_summary_global_by_event_name
    WHERE event_name = 'memory/temptable/physical_disk'
    INTO @id1;

SELECT * FROM
    t AS t1,
    t AS t2,
    t AS t3,
    t AS t4,
    t AS t5,
    t AS t6
    ORDER BY 1
    LIMIT 2;

SELECT count_alloc
    FROM performance_schema.memory_summary_global_by_event_name
    WHERE event_name = 'memory/temptable/physical_disk'
    INTO @id2;

SELECT @@internal_tmp_mem_storage_engine;
SELECT (@id1=@id2);

SET @@internal_tmp_mem_storage_engine = TempTable;
SET GLOBAL temptable_max_ram = 2097152;
SELECT count_alloc
    FROM performance_schema.memory_summary_global_by_event_name
    WHERE event_name = 'memory/temptable/physical_disk'
    INTO @id1;

SELECT * FROM
    t AS t1,
    t AS t2,
    t AS t3,
    t AS t4,
    t AS t5,
    t AS t6
    ORDER BY 1
    LIMIT 2;

SELECT count_alloc
    FROM performance_schema.memory_summary_global_by_event_name
    WHERE event_name = 'memory/temptable/physical_disk'
    INTO @id2;

SELECT @@internal_tmp_mem_storage_engine;
SELECT (@id1<@id2);

SET @@internal_tmp_mem_storage_engine = default;
SET GLOBAL temptable_max_ram = default;

SET @@internal_tmp_mem_storage_engine = TempTable;
SET GLOBAL temptable_max_ram = 2097152;
SET debug = '+d,temptable_fetch_from_disk_return_null';

-- When both RAM and MMAP limit is exhausted, optimizer shall recover by spilling over to new tmp disk tables (InnoDB)
-- disable_result_log
SELECT * FROM
    t AS t1,
    t AS t2,
    t AS t3,
    t AS t4,
    t AS t5,
    t AS t6
    ORDER BY 1
    LIMIT 2;

SELECT @@internal_tmp_mem_storage_engine;

SET @@internal_tmp_mem_storage_engine = default;
SET GLOBAL temptable_max_ram = default;
SET debug = '-d,temptable_fetch_from_disk_return_null';

-- ---------------------------------------------------------------------
-- Cleanup
--

DROP TABLE t;
SET optimizer_switch="hash_join=on";
