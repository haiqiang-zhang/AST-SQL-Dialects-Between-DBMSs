SELECT DISTINCT hobbies_r.name, name(hobbies_r.equipment) FROM hobbies_r
  ORDER BY 1,2;
SELECT hobbies_r.name, (hobbies_r.equipment).name FROM hobbies_r;
SELECT hobbies_by_name('basketball');
SELECT * FROM equipment(ROW('skywalking', 'mer'));
SELECT *, (equipment(CAST((h.*) AS hobbies_r))).name FROM hobbies_r h;
