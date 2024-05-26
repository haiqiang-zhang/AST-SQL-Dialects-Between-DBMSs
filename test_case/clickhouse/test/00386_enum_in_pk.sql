SELECT cityHash64(groupArray(x)) FROM enum_pk WHERE x = '0';
DROP TABLE enum_pk;
