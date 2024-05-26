print '-- bin_at()';
print bin_at(6.5, 2.5, 7);
Bin_at_test | summarize sum(Num) by d = todatetime(bin_at(Date, 1d, datetime('2018-02-24 15:14:00'))) | order by d;
print '-- bin()';
print bin(4.5, 1);
