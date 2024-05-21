set dialect = 'kusto';
print '-- isnan --';
print isnan(double(nan));
print isnan(4.2);
print isnan(4);
print isnan(real(+inf));
print isnan(dynamic(null));