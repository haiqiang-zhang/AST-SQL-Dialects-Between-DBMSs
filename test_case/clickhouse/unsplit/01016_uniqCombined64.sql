
-- but hence checking with 1e10 values takes too much time (~45 secs), this
-- test is just to ensure that the result is different (and to document the
-- outcome).

SELECT uniqCombined(number)   FROM numbers(1e7);
SELECT uniqCombined64(number) FROM numbers(1e7);
