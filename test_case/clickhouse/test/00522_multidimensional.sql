SELECT sum(cityHash64(toString(value))) FROM multidimensional;
DROP TABLE multidimensional;
