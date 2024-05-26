optimize table test final;
SELECT count() FROM test PREWHERE hasToken(h['user-agent'], 'bulk')  WHERE hasToken(h['user-agent'], 'tests') and t = 'xxx';
SELECT count() FROM test WHERE hasToken(h['user-agent'], 'bulk') and hasToken(h['user-agent'], 'tests') and t = 'xxx';
