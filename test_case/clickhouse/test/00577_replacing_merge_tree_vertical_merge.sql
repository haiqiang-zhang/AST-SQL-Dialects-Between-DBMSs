select * from tab_00577 order by version;
OPTIMIZE TABLE tab_00577 FINAL CLEANUP;
select * from tab_00577;
drop table tab_00577;
DROP TABLE IF EXISTS testCleanupR1;
SELECT '== (Replicas) Test optimize ==';
DROP TABLE IF EXISTS testCleanupR1;
