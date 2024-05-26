prepare q123 as select $param, $other_name, $param;
prepare q01 as select $1, ?, $2;
execute q123(param := 5, other_name := 3);
