SELECT count() from 02581_trips WHERE description = '';
SELECT name FROM system.parts WHERE database=currentDatabase() AND table = '02581_trips' AND active ORDER BY name;
DROP TABLE 02581_trips;
