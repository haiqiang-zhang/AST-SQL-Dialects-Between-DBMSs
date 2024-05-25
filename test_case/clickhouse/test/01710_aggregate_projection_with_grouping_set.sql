select dim1, dim2, count() from test group by grouping sets ((dim1, dim2), dim1) order by dim1, dim2, count();
select dim1, dim2, count() from test group by dim1, dim2 with rollup order by dim1, dim2, count();
select dim1, dim2, count() from test group by dim1, dim2 with cube order by dim1, dim2, count();
select dim1, dim2, count() from test group by dim1, dim2 with totals order by dim1, dim2, count();
drop table test;
