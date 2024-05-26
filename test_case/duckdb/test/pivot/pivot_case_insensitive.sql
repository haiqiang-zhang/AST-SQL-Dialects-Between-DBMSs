FROM Cities
PIVOT (
    array_agg(id)
    FOR
        name IN ('test','Test')
);
FROM Cities
PIVOT (
    array_agg(id), sum(id)
    FOR
        name IN ('test','Test')
);
