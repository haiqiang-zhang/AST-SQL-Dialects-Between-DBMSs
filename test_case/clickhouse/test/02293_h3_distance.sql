SELECT h3Distance(stringToH3(start), stringToH3(end)) FROM h3_indexes ORDER BY id;
DROP TABLE h3_indexes;
