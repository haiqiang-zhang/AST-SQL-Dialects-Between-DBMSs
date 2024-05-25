CREATE FUNCTION hobby_construct(text, text)
   RETURNS hobbies_r
   AS 'select $1 as name, $2 as hobby'
   LANGUAGE SQL;
CREATE FUNCTION hobby_construct_named(name text, hobby text)
   RETURNS hobbies_r
   AS 'select name, hobby'
   LANGUAGE SQL;
CREATE FUNCTION hobbies_by_name(hobbies_r.name%TYPE)
   RETURNS hobbies_r.person%TYPE
   AS 'select person from hobbies_r where name = $1'
   LANGUAGE SQL;
CREATE FUNCTION equipment(hobbies_r)
   RETURNS setof equipment_r
   AS 'select * from equipment_r where hobby = $1.name'
   LANGUAGE SQL;
CREATE FUNCTION equipment_named(hobby hobbies_r)
   RETURNS setof equipment_r
   AS 'select * from equipment_r where equipment_r.hobby = equipment_named.hobby.name'
   LANGUAGE SQL;
CREATE FUNCTION equipment_named_ambiguous_1a(hobby hobbies_r)
   RETURNS setof equipment_r
   AS 'select * from equipment_r where hobby = equipment_named_ambiguous_1a.hobby.name'
   LANGUAGE SQL;
CREATE FUNCTION equipment_named_ambiguous_1b(hobby hobbies_r)
   RETURNS setof equipment_r
   AS 'select * from equipment_r where equipment_r.hobby = hobby.name'
   LANGUAGE SQL;
CREATE FUNCTION equipment_named_ambiguous_1c(hobby hobbies_r)
   RETURNS setof equipment_r
   AS 'select * from equipment_r where hobby = hobby.name'
   LANGUAGE SQL;
CREATE FUNCTION equipment_named_ambiguous_2a(hobby text)
   RETURNS setof equipment_r
   AS 'select * from equipment_r where hobby = equipment_named_ambiguous_2a.hobby'
   LANGUAGE SQL;
CREATE FUNCTION equipment_named_ambiguous_2b(hobby text)
   RETURNS setof equipment_r
   AS 'select * from equipment_r where equipment_r.hobby = hobby'
   LANGUAGE SQL;
SELECT DISTINCT hobbies_r.name, name(hobbies_r.equipment) FROM hobbies_r
  ORDER BY 1,2;
SELECT hobbies_r.name, (hobbies_r.equipment).name FROM hobbies_r;
SELECT name(equipment(hobby_construct(text 'skywalking', text 'mer')));
SELECT name(equipment(hobby_construct_named(text 'skywalking', text 'mer')));
SELECT name(equipment_named(hobby_construct_named(text 'skywalking', text 'mer')));
SELECT name(equipment_named_ambiguous_1a(hobby_construct_named(text 'skywalking', text 'mer')));
SELECT name(equipment_named_ambiguous_1b(hobby_construct_named(text 'skywalking', text 'mer')));
SELECT name(equipment_named_ambiguous_1c(hobby_construct_named(text 'skywalking', text 'mer')));
SELECT name(equipment_named_ambiguous_2a(text 'skywalking'));
SELECT name(equipment_named_ambiguous_2b(text 'skywalking'));
SELECT hobbies_by_name('basketball');
SELECT * FROM equipment(ROW('skywalking', 'mer'));
SELECT name(equipment(ROW('skywalking', 'mer')));
SELECT *, name(equipment(h.*)) FROM hobbies_r h;
SELECT *, (equipment(CAST((h.*) AS hobbies_r))).name FROM hobbies_r h;
