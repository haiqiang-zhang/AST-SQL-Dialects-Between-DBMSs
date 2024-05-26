SELECT mapUpdate(mapFilter((k, v) -> (k in ('fruit')), tags), map('season', 'autumn')) FROM map_test;
DROP TABLE map_test;
