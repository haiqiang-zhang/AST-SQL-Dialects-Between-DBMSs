
do lcase(ltrim(from_unixtime(0,' %T ')));
          substring_index(uuid(),0,1.111111e+308));

set @old_collation_connection=@@collation_connection;
set collation_connection="utf8_general_ci";
set collation_connection=@old_collation_connection;
