OPTIMIZE TABLE testNullableStatesAgg FINAL;
select count() from testNullableStates;
select ' ---- select without states ---- ';
SELECT id, count(),
    min(string),
    max(string),
    floor(min(float64),5),
    floor(max(float64),5),
    floor(avg(float64),5),
    floor(sum(float64),5),
    floor(min(float32),5),
    floor(max(float32),5),
    floor(avg(float32),5),
    floor(sum(float32),5),
    min(decimal325),
    max(decimal325),
    avg(decimal325),
    sum(decimal325),
    min(date),
    max(date),
    min(datetime),
    max(datetime),
    min(datetime64),
    max(datetime64),
    min(int64),
    max(int64),
    avg(int64),
    sum(int64),
    min(int32),
    max(int32),
    avg(int32),
    sum(int32),
    min(int16),
    max(int16),
    avg(int16),
    sum(int16),
    min(int8),
    max(int8),
    avg(int8),
    sum(int8)
FROM testNullableStates
GROUP BY id
ORDER BY id ASC;
select ' ---- select with states ---- ';
SELECT id, count(),
    minMerge(stringMin),
    maxMerge(stringMax),
    floor(minMerge(float64Min),5),
    floor(maxMerge(float64Max),5),
    floor(avgMerge(float64Avg),5),
    floor(sumMerge(float64Sum),5),
    floor(minMerge(float32Min),5),
    floor(maxMerge(float32Max),5),
    floor(avgMerge(float32Avg),5),
    floor(sumMerge(float32Sum),5),
    minMerge(decimal325Min),
    maxMerge(decimal325Max),
    avgMerge(decimal325Avg),
    sumMerge(decimal325Sum),
    minMerge(dateMin),
    maxMerge(dateMax),
    minMerge(datetimeMin),
    maxMerge(datetimeMax),
    minMerge(datetime64Min),
    maxMerge(datetime64Max),
    minMerge(int64Min),
    maxMerge(int64Max),
    avgMerge(int64Avg),
    sumMerge(int64Sum),
    minMerge(int32Min),
    maxMerge(int32Max),
    avgMerge(int32Avg),
    sumMerge(int32Sum),
    minMerge(int16Min),
    maxMerge(int16Max),
    avgMerge(int16Avg),
    sumMerge(int16Sum),
    minMerge(int8Min),
    maxMerge(int8Max),
    avgMerge(int8Avg),
    sumMerge(int8Sum)
FROM testNullableStatesAgg
GROUP BY id
ORDER BY id ASC;
select ' ---- select row with nulls without states ---- ';
select ' ---- select row with nulls with states ---- ';
select ' ---- select no rows without states ---- ';
select ' ---- select no rows with states ---- ';
DROP TABLE testNullableStates;
DROP TABLE testNullableStatesAgg;
