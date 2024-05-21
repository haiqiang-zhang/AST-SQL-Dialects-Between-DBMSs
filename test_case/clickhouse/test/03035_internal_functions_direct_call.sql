-- However, we cannot completely forbid it (becasue query can came from another server, for example)
-- Check that usage of these functions does not lead to crash or logical error

SELECT __actionName();
SELECT __actionName('aaa', 'aaa', 'aaa');
SELECT __actionName('aaa', '') SETTINGS allow_experimental_analyzer = 1;
SELECT __actionName('aaa', materialize('aaa'));
SELECT __actionName(materialize('aaa'), 'aaa');
SELECT __actionName('aaa', 'aaa');
SELECT concat(__actionName('aaa', toNullable('x')), '1') GROUP BY __actionName('aaa', 'x');
SELECT __getScalar('aaa');
SELECT __getScalar();
SELECT __getScalar(1);
SELECT __getScalar(materialize('1'));
SELECT __scalarSubqueryResult('1');
SELECT 'a' || __scalarSubqueryResult(a), materialize('1') as a;
SELECT __scalarSubqueryResult(a, a), materialize('1') as a;
SELECT 1 as `__grouping_set`;