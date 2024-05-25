SELECT __actionName('aaa', 'aaa');
SELECT __scalarSubqueryResult('1');
SELECT 'a' || __scalarSubqueryResult(a), materialize('1') as a;
SELECT 1 as `__grouping_set`;
