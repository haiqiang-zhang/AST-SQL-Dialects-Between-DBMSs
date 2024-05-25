set dialect = 'kusto';
print '-- isnan --';
print isnan(double(nan));
print isnan(4.2);
