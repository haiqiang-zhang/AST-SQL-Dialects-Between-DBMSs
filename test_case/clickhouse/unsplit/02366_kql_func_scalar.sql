DROP TABLE IF EXISTS Bin_at_test;
CREATE TABLE Bin_at_test
(    
    `Date` DateTime('UTC'),
    Num Nullable(UInt8)
) ENGINE = Memory;
INSERT INTO Bin_at_test VALUES ('2018-02-24T15:14:01',3), ('2018-02-23T16:14:01',4), ('2018-02-26T15:14:01',5);
set dialect = 'kusto';
print '-- bin_at()';
print bin_at(6.5, 2.5, 7);
Bin_at_test | summarize sum(Num) by d = todatetime(bin_at(Date, 1d, datetime('2018-02-24 15:14:00'))) | order by d;
print '-- bin()';
print bin(4.5, 1);
