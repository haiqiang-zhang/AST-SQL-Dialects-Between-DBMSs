CREATE TABLE landing (n Int64) engine=MergeTree order by n;
CREATE TABLE target  (n Int64) engine=MergeTree order by n;
CREATE MATERIALIZED VIEW landing_to_target TO target AS
    SELECT n + throwIf(n == 3333)
    FROM landing;
SELECT 'no_transaction_landing', count() FROM landing;
SELECT 'no_transaction_target', count() FROM target;
TRUNCATE TABLE landing;
TRUNCATE TABLE target;
SELECT 'after_transaction_landing', count() FROM landing;
SELECT 'after_transaction_target', count() FROM target;
SELECT 'after_implicit_txn_in_query_settings_landing', count() FROM landing;
SELECT 'after_implicit_txn_in_query_settings_target', count() FROM target;
SET implicit_transaction=True;
-- Verify that you don't have to manually close transactions with implicit_transaction
SET implicit_transaction=True;
SELECT 'out_transaction', count() FROM target;
SET implicit_transaction=False;
SYSTEM FLUSH LOGS;
SET implicit_transaction=1;
