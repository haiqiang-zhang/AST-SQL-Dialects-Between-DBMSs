create table x( id UInt64, t  AggregateFunction(argMax, Enum8('<Empty>' = -1, 'Male' = 1, 'Female' = 2), UInt64) DEFAULT arrayReduce('argMaxState', ['cast(-1, \'Enum8(\'<Empty>\' = -1, \'Male\' = 1, \'Female\' = 2)'], [toUInt64(0)]) ) Engine=MergeTree ORDER BY id;