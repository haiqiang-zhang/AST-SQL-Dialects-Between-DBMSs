SELECT sum(if(materialize(0), toNullable(1), 0));
SELECT sum(if(s == '', v, 0)) b from VALUES ('v Nullable(Int64), s String',(1, 'x'));
SELECT sumOrNull(if(materialize(0), toNullable(1), 0));
SELECT sum(if(materialize(0), toNullable(1), 0)) settings aggregate_functions_null_for_empty=1;
SELECT sum(if(materialize(0), 1, 0)) settings aggregate_functions_null_for_empty=1;
SELECT sum(if(materialize(1), toNullable(1), 10)) settings aggregate_functions_null_for_empty=1;
SELECT sum(if(materialize( 1), 1, 10)) settings aggregate_functions_null_for_empty=1;
