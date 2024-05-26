SELECT id, map FROM map_containsKeyLike_test WHERE mapContainsKeyLike(map, '1-%') = 1;
SELECT id, map FROM map_containsKeyLike_test WHERE mapContainsKeyLike(map, '3-%') = 0 order by id;
DROP TABLE map_containsKeyLike_test;
SELECT mapContainsKeyLike(map('aa', 1, 'bb', 2), 'a%');
SELECT mapExtractKeyLike(map('aa', NULL, 'bb', NULL), 'a%');
