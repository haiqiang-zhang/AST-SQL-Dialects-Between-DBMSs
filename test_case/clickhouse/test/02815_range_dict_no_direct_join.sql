CREATE DICTIONARY discounts_dict
(
    advertiser_id UInt64,
    discount_start_date Date,
    discount_end_date Nullable(Date),
    amount Float64
)
PRIMARY KEY advertiser_id
SOURCE(CLICKHOUSE(TABLE discounts))
LIFETIME(MIN 600 MAX 900)
LAYOUT(RANGE_HASHED(RANGE_LOOKUP_STRATEGY 'max'))
RANGE(MIN discount_start_date MAX discount_end_date);
CREATE TABLE ids (id UInt64) ENGINE = Memory;
INSERT INTO ids SELECT * FROM numbers(10);
SELECT id, amount FROM ids INNER JOIN discounts_dict ON id = advertiser_id ORDER BY id, amount SETTINGS join_algorithm = 'direct,hash';
SELECT id, amount FROM ids INNER JOIN discounts_dict ON id = advertiser_id ORDER BY id, amount SETTINGS join_algorithm = 'default';
