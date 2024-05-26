SELECT 1 AS x, 2 AS y, least(x, y), greatest(x, y), least(x, materialize(y)), greatest(materialize(x), y), greatest(materialize(x), materialize(y)), toTypeName(least(x, y));
SELECT greatest(now(), now() + 10) - now();
SELECT greatest(today(), yesterday() + 10) - today();
