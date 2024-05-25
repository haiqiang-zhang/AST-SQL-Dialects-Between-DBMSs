create procedure proc_1() install plugin my_plug soname '/root/some_plugin.so';
drop procedure proc_1;
prepare abc from "install plugin my_plug soname '/root/some_plugin.so'";
deallocate prepare abc;
