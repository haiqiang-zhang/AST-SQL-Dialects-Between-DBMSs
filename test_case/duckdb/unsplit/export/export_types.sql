BEGIN TRANSACTION;
CREATE TYPE mood AS ENUM ('happy', 'sad', 'curious');
CREATE TYPE doom as mood;
create table tbl1 (a mood, b doom);
create table tbl2 (my_struct STRUCT(a mood, b doom));
CREATE TYPE doom_mood as STRUCT(a mood, b doom);
CREATE TYPE mood_list as mood[];
CREATE TYPE my_union as UNION(a doom, b mood);
CREATE TYPE mood_map as MAP(doom, mood);
CREATE TYPE my_special_type as VARCHAR;
CREATE TABLE tbl3 (my_struct doom_mood);
EXPORT DATABASE '__TEST_DIR__/export_types' (FORMAT CSV);
ROLLBACK;