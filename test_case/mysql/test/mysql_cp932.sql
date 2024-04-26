
--
-- BUG#16217 - MySQL client misinterprets multi-byte char as escape `\' 
--

-- new command \C or charset
--exec $MYSQL --default-character-set=utf8mb3 test -e "\C cp932 \g"
--exec $MYSQL --default-character-set=cp932 test -e "charset utf8mb3;

-- its usage to switch internally in mysql to requested charset
--character_set latin1
--execw $MYSQL --default-character-set=latin1 test -e "charset cp932;
