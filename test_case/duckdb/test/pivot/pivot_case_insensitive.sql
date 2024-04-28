PRAGMA enable_verification;
CREATE TABLE Cities (Name VARCHAR, id INTEGER);
INSERT INTO Cities VALUES ('Test', 1);
INSERT INTO Cities VALUES ('test',2);;
SET pivot_filter_threshold=1;;
FROM Cities
PIVOT (
    array_agg(id)
    FOR
        name IN ('test','Test')
);;
FROM Cities
PIVOT (
    array_agg(id), sum(id)
    FOR
        name IN ('test','Test')
);;
