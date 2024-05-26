SELECT 'dictGet';
SELECT tuple(x, y) as key,
    dictGet('01760_db.dict_array', 'name', key),
    dictGet('01760_db.dict_array', 'value', key),
    dictGet('01760_db.dict_array', 'value_nullable', key)
FROM 01760_db.points
ORDER BY x, y;
SELECT 'dictGetOrDefault';
SELECT tuple(x, y) as key,
    dictGetOrDefault('01760_db.dict_array', 'name', key, 'DefaultName'),
    dictGetOrDefault('01760_db.dict_array', 'value', key, 30),
    dictGetOrDefault('01760_db.dict_array', 'value_nullable', key, 40)
FROM 01760_db.points
ORDER BY x, y;
SELECT 'dictHas';
SELECT tuple(x, y) as key,
    dictHas('01760_db.dict_array', key),
    dictHas('01760_db.dict_array', key),
    dictHas('01760_db.dict_array', key)
FROM 01760_db.points
ORDER BY x, y;
SELECT 'check NaN or infinite point input';
DROP DICTIONARY 01760_db.dict_array;
DROP TABLE 01760_db.points;
DROP TABLE 01760_db.polygons;
DROP DATABASE 01760_db;
