CREATE MATERIALIZED VIEW IF NOT EXISTS forward TO session AS
SELECT
    day,
    uid
FROM queue;
insert into queue values ('2019-05-01', 'test');
SELECT * FROM queue;
SELECT * FROM session;
SELECT * FROM forward;
DROP TABLE session;
DROP TABLE queue;
DROP TABLE forward;
