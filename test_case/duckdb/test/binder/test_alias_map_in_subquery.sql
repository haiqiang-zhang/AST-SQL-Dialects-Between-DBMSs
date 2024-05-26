SELECT (WITH keys AS (
    		SELECT example AS k
    	), nonNull AS (
    		SELECT keys.k, example AS v
    		FROM keys
    		WHERE v IS NOT NULL
    	)
    	SELECT nonNull.v
    	FROM nonNull
)
FROM tbl;
SELECT (WITH keys AS (SELECT unnest(json_keys(example)) AS k), nonNull AS (
    		SELECT keys.k, example->keys.k AS v
    		FROM keys WHERE v IS NOT NULL
    	)
    	SELECT json_group_object(nonNull.k, nonNull.v)
    	FROM nonNull
)
FROM testjson;
SELECT strip_null_value('{ "location" : { "address" : "123 Main St" }, "sampleField" : null, "anotherField" : 123, "yetAnotherField" : "abc" }')
AS example;
SELECT strip_null_value(example) FROM testjson;
WITH x AS (
	SELECT '{ "location" : { "address" : "123 Main St" }, "sampleField" : null, "anotherField" : 123, "yetAnotherField" : "abc" }'
	AS example)
SELECT strip_null_value(x.example) AS test
FROM x;
