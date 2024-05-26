PRAGMA enable_verification;
CREATE VIEW v1 AS select i, lag(i) over named_window from (values (1), (2), (3)) as t (i) window named_window as (order by i);
CREATE TABLE a (id INT);
