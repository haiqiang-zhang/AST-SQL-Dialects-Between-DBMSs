
--
-- Bug #20665: All commands supported in Stored Procedures should work in
-- Prepared Statements
--

create procedure proc_1() install plugin my_plug soname '/root/some_plugin.so';
drop procedure proc_1;
