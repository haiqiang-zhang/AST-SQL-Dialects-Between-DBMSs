SET send_logs_level = 'fatal';
SELECT '- const pattern';
select multiFuzzyMatchAny('abc', 0, ['a1c']) from system.numbers limit 3;
select multiFuzzyMatchAnyIndex('string', 1, ['zorro$', '^tring', 'ip$', 'how.*', 'it{2}', 'works']);
select arraySort(multiFuzzyMatchAllIndices('halo some wrld', 2, ['some random string', '^halo.*world$', '^halo.*world$', '^halo.*world$', '^hallllo.*world$']));
select multiFuzzyMatchAllIndices('halo some wrld', 2, ['^halllllo.*world$', 'some random string']);
SELECT '- non-const pattern';
