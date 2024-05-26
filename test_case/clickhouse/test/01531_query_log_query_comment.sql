select /* test=01531, enable_global_with_statement=0 */ 2;
system flush logs;
set enable_global_with_statement=1;
select /* test=01531, enable_global_with_statement=1 */ 2;
system flush logs;
