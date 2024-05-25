select tab1.a1, tab1_copy.a1, tab1.b1 from tab1 any left join tab1_copy on tab1.b1 + 3 = tab1_copy.b1 + 2;
drop table tab1;
drop table tab1_copy;
