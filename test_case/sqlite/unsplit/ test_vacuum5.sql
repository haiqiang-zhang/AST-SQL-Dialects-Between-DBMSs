VACUUM main;
PRAGMA main.integrity_check;
VACUUM temp;
PRAGMA temp.page_count;
VACUUM;
