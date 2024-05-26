SELECT '- const pattern';
select multiMatchAny('123', ['1']);
select multiMatchAnyIndex('123', ['1']);
select multiMatchAllIndices('123', ['1']);
select multiFuzzyMatchAny('123', 0, ['1']);
select multiFuzzyMatchAnyIndex('123', 0, ['1']);
select multiFuzzyMatchAllIndices('123', 0, ['1']);
SELECT '- non-const pattern';
