prepare q123 as select $param, $other_name, $param;;
execute q123(param := 5, 3);
prepare q01 as select $1, ?, $2;;
execute q01(4, 2, 0);
prepare q02 as select $1, $param, $2;;
execute q01(a, 2, 0);
execute q123(param := 5, other_name := 3);;
