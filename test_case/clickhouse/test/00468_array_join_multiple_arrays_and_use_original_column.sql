SELECT nx FROM nested ARRAY JOIN nest.x AS nx, nest.y AS ny WHERE notEmpty(nest.y);
SELECT 1 FROM nested ARRAY JOIN nest.x AS nx, nest.y AS ny WHERE notEmpty(nest.y);
SELECT nx, ny FROM nested ARRAY JOIN nest.x AS nx, nest.y AS ny WHERE notEmpty(nest.y);
SELECT nx FROM nested ARRAY JOIN nest.x AS nx, nest.y AS ny WHERE notEmpty(nest.x);
SELECT nx, nest.y FROM nested ARRAY JOIN nest.x AS nx, nest.y AS ny;
SELECT nx, ny, nest.x, nest.y FROM nested ARRAY JOIN nest.x AS nx, nest.y AS ny;
DROP TABLE nested;
