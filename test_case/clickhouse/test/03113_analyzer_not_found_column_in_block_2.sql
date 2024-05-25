-- inconsistencies for distributed queries.
set optimize_if_transform_strings_to_enum=0;
set allow_experimental_analyzer=1;
drop table if exists t;
