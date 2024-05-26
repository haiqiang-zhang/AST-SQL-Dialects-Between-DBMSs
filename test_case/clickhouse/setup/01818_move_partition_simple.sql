DROP TABLE IF EXISTS main_table_01818;
DROP TABLE IF EXISTS tmp_table_01818;
CREATE TABLE main_table_01818
(
    `id` UInt32,
    `advertiser_id` String,
    `campaign_id` String,
    `name` String,
    `budget` Float64,
    `budget_mode` String,
    `landing_type` String,
    `status` String,
    `modify_time` String,
    `campaign_type` String,
    `campaign_create_time` DateTime,
    `campaign_modify_time` DateTime,
    `create_time` DateTime,
    `update_time` DateTime
)
ENGINE = MergeTree
PARTITION BY advertiser_id
ORDER BY campaign_id
SETTINGS index_granularity = 8192;
CREATE TABLE tmp_table_01818
(
    `id` UInt32,
    `advertiser_id` String,
    `campaign_id` String,
    `name` String,
    `budget` Float64,
    `budget_mode` String,
    `landing_type` String,
    `status` String,
    `modify_time` String,
    `campaign_type` String,
    `campaign_create_time` DateTime,
    `campaign_modify_time` DateTime,
    `create_time` DateTime,
    `update_time` DateTime
)
ENGINE = MergeTree
PARTITION BY advertiser_id
ORDER BY campaign_id
SETTINGS index_granularity = 8192;
