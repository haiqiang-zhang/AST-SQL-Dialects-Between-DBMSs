CREATE INDEX x1i ON x1(one+"two"+"four") WHERE "five";
ALTER TABLE x1 RENAME two TO 'four';
SELECT sql FROM sqlite_schema;
SELECT sql FROM sqlite_temp_schema;
