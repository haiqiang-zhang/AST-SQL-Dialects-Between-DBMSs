SELECT parts, active_parts,total_marks FROM system.tables WHERE name = 'check_system_tables' AND database = currentDatabase();
INSERT INTO check_system_tables VALUES (1, 1, 1);
SELECT parts, active_parts,total_marks FROM system.tables WHERE name = 'check_system_tables' AND database = currentDatabase();
INSERT INTO check_system_tables VALUES (1, 2, 1);
SELECT parts, active_parts,total_marks FROM system.tables WHERE name = 'check_system_tables' AND database = currentDatabase();
ALTER TABLE check_system_tables DETACH PARTITION 1;
SELECT parts, active_parts,total_marks FROM system.tables WHERE name = 'check_system_tables' AND database = currentDatabase();
DROP TABLE IF EXISTS check_system_tables;