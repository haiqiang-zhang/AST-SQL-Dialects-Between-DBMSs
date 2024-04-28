SET custom_user_agent='something else';
RESET custom_user_agent;
SET duckdb_api='something else';
SELECT current_setting('custom_user_agent');
SELECT regexp_matches(user_agent, '^duckdb/.*(.*)') FROM pragma_user_agent();