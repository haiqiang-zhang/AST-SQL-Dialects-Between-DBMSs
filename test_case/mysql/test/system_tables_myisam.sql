CREATE TABLE t1 (f1 INT);
DROP TABLE t1;
SELECT table_schema, table_name, engine FROM information_schema.tables
                                        WHERE table_schema='mysql'
                                              AND engine='MyISAM';
SELECT table_schema, table_name, engine FROM information_schema.tables
                                        WHERE table_schema='mysql'
                                              AND engine='MyISAM';
