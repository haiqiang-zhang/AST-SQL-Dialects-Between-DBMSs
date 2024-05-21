set allow_experimental_analyzer=0;
set allow_experimental_variant_type=1;
set use_variant_as_common_type=1;
select toTypeName(res), if(1, [1,2,3], 'str_1') as res;
select toTypeName(res), if(1, [1,2,3], 'str_1'::Nullable(String)) as res;
select toTypeName(res), if(0, [1,2,3], 'str_1') as res;
select toTypeName(res), if(0, [1,2,3], 'str_1'::Nullable(String)) as res;
select toTypeName(res), if(NULL, [1,2,3], 'str_1') as res;
select toTypeName(res), if(NULL, [1,2,3], 'str_1'::Nullable(String)) as res;
