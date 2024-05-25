CREATE TABLE t (c VARCHAR(128));
INSERT INTO t VALUES
    (REPEAT('a', 128)),
    (REPEAT('b', 128)),
    (REPEAT('c', 128)),
    (REPEAT('d', 128));
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
SELECT (@id1=@id2);
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
SELECT (@id1<@id2);
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
DROP TABLE t;
