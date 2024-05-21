SELECT CAST([('a', 1), ('b', 2)], 'Map(String, UInt8)');
SELECT CAST([('abc', 22), ('def', 33)], 'Map(String, UInt8)');
SELECT CAST([(10, [11, 12]), (13, [14, 15])], 'Map(UInt8, Array(UInt8))');
