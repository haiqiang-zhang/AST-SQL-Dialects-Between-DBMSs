SELECT substring(h3CellAreaRads2(h3_index)::String, 1, 10) FROM h3_indexes ORDER BY h3_index;
DROP TABLE h3_indexes;
