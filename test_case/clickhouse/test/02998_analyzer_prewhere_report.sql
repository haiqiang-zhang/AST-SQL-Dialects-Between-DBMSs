SELECT
    hits.date,
    arrayFilter(x -> (x IN (2, 3)), data) AS filtered
FROM hits
WHERE arrayExists(x -> (x IN (2, 3)), data)
SETTINGS allow_experimental_analyzer = 1;
