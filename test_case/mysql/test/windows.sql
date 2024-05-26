prepare abc from "install plugin my_plug soname '\\\\root\\\\some_plugin.dll'";
deallocate prepare abc;
SELECT VARIABLE_NAME FROM performance_schema.global_variables
  WHERE VARIABLE_NAME = 'socket';
