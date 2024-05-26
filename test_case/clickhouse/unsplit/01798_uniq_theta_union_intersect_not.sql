SELECT 'uniqTheta union test';
select finalizeAggregation(uniqThetaUnion(a, b)), finalizeAggregation(a), finalizeAggregation(b) from (select arrayReduce('uniqThetaState',[]) as a, arrayReduce('uniqThetaState',[]) as b );
SELECT 'uniqTheta intersect test';
SELECT 'uniqTheta union test';
SELECT 'uniqTheta retention test';
SELECT 'uniqTheta retention with AggregatingMergeTree test';
DROP TABLE IF EXISTS test1;
CREATE TABLE test1
(
    `year` String ,
    `uv` AggregateFunction(uniqTheta, Int64)
)
ENGINE = AggregatingMergeTree()
ORDER BY (year);
INSERT INTO TABLE test1(year, uv) select '2021',uniqThetaState(toInt64(1));
INSERT INTO TABLE test1(year, uv) select '2021',uniqThetaState(toInt64(2));
INSERT INTO TABLE test1(year, uv) select '2021',uniqThetaState(toInt64(3));
INSERT INTO TABLE test1(year, uv) select '2021',uniqThetaState(toInt64(4));
INSERT INTO TABLE test1(year, uv) select '2022',uniqThetaState(toInt64(1));
INSERT INTO TABLE test1(year, uv) select '2022',uniqThetaState(toInt64(3));
DROP TABLE IF EXISTS test1;
SELECT 'uniqTheta retention with MergeTree test';
DROP TABLE IF EXISTS test2;
CREATE TABLE test2
(
    `year` String ,
    `uv`  Int64
)
ENGINE = MergeTree()
ORDER BY (year);
INSERT INTO TABLE test2(year, uv) select '2021',1;
INSERT INTO TABLE test2(year, uv) select '2021',2;
INSERT INTO TABLE test2(year, uv) select '2021',3;
INSERT INTO TABLE test2(year, uv) select '2021',4;
INSERT INTO TABLE test2(year, uv) select '2022',1;
INSERT INTO TABLE test2(year, uv) select '2022',3;
DROP TABLE IF EXISTS test2;
