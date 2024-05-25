SELECT DISTINCT meta_source_req_uuid
FROM bug_14144
WHERE meta_source_type = 'missing'
ORDER BY meta_source_req_uuid ASC;
TRUNCATE TABLE bug_14144;
INSERT INTO bug_14144 SELECT generateUUIDv4(), number, 'missing' FROM numbers(10000);
SELECT COUNT() FROM (
   SELECT DISTINCT meta_source_req_uuid
   FROM bug_14144
   WHERE meta_source_type = 'missing'
   ORDER BY meta_source_req_uuid ASC
   LIMIT 100000
);
DROP TABLE bug_14144;
