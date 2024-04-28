PRAGMA enable_verification;
CREATE TABLE integers AS SELECT 42 i, 84 j UNION ALL SELECT 13, 14;
SELECT COLUMNS([x for x in COLUMNS(*)]) FROM integers;
SELECT * + 42 FROM integers;
SELECT COLUMNS([x for x in (*) if x = 'k']) FROM integers;
SELECT COLUMNS(['k']) FROM integers;
SELECT COLUMNS([43]) FROM integers;
SELECT COLUMNS([NULL]) FROM integers;
SELECT COLUMNS([]::VARCHAR[]) FROM integers;
SELECT COLUMNS(NULL::VARCHAR[]) FROM integers;
SELECT COLUMNS(NULL::VARCHAR) FROM integers;
SELECT COLUMNS(['i']) + COLUMNS(['j']) FROM integers;
SELECT COLUMNS([x for x in (* REPLACE (i AS i))]) FROM integers;
SELECT COLUMNS([x for x in *]) FROM integers;
SELECT COLUMNS([x for x in (*) if x <> 'i']) FROM integers;
SELECT COLUMNS(x -> x <> 'i') FROM integers;
SELECT COLUMNS([x for x in (*) if x SIMILAR TO 'i']) FROM integers;
SELECT COLUMNS(['i', 'i']) FROM integers;
SELECT COLUMNS(list_concat(['i'], ['i'])) FROM integers;
SELECT COLUMNS([x for x in (* EXCLUDE (i))]) FROM integers;
SELECT COLUMNS(['i']) + COLUMNS(['i']) FROM integers;
SELECT COLUMNS([i, j]) FROM integers;
SELECT COLUMNS([x for x in (*) if x LIKE 'i']) FROM integers i1 JOIN integers i2 USING (i);
SELECT COLUMNS([x for x in (*) if x LIKE 'i']) FROM integers i1 JOIN integers i2 ON (i1.i=i2.i);