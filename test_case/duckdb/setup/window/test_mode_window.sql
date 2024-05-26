SET default_null_order='nulls_first';
PRAGMA enable_verification;
PRAGMA verify_external;
create table modes as select range r from range(10) union all values (NULL), (NULL), (NULL);
