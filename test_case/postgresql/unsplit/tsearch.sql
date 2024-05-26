SELECT oid, prsname
FROM pg_ts_parser
WHERE prsnamespace = 0 OR prsstart = 0 OR prstoken = 0 OR prsend = 0 OR
      prslextype = 0;
SELECT oid, dictname
FROM pg_ts_dict
WHERE dictnamespace = 0 OR dictowner = 0 OR dicttemplate = 0;
SELECT oid, tmplname
FROM pg_ts_template
WHERE tmplnamespace = 0 OR tmpllexize = 0;
SELECT oid, cfgname
FROM pg_ts_config
WHERE cfgnamespace = 0 OR cfgowner = 0 OR cfgparser = 0;
SELECT mapcfg, maptokentype, mapseqno
FROM pg_ts_config_map
WHERE mapcfg = 0 OR mapdict = 0;
SELECT * FROM
  ( SELECT oid AS cfgid, (ts_token_type(cfgparser)).tokid AS tokid
    FROM pg_ts_config ) AS tt
RIGHT JOIN pg_ts_config_map AS m
    ON (tt.cfgid=m.mapcfg AND tt.tokid=m.maptokentype)
WHERE
    tt.cfgid IS NULL OR tt.tokid IS NULL;
CREATE TABLE test_tsvector(
	t text,
	a tsvector
);
ANALYZE test_tsvector;
SELECT count(*) FROM test_tsvector WHERE a @@ 'wr|qh';
create index wowidx on test_tsvector using gist (a);
SET enable_seqscan=OFF;
SET enable_indexscan=ON;
SET enable_bitmapscan=OFF;
explain (costs off) SELECT count(*) FROM test_tsvector WHERE a @@ 'wr|qh';
SET enable_indexscan=OFF;
SET enable_bitmapscan=ON;
CREATE INDEX wowidx2 ON test_tsvector USING gist (a tsvector_ops(siglen=1));
DROP INDEX wowidx;
DROP INDEX wowidx2;
CREATE INDEX wowidx ON test_tsvector USING gist (a tsvector_ops(siglen=484));
RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
DROP INDEX wowidx;
CREATE INDEX wowidx ON test_tsvector USING gin (a);
SET enable_seqscan=OFF;
RESET enable_seqscan;
INSERT INTO test_tsvector VALUES ('???', 'DFG:1A,2B,6C,10 FGH');
SELECT * FROM ts_stat('SELECT a FROM test_tsvector') ORDER BY ndoc DESC, nentry DESC, word LIMIT 10;
SELECT ts_lexize('english_stem', 'skies');
SELECT * FROM ts_token_type('default');
SELECT * FROM ts_parse('default', '345 qwe@efd.r '' http://www.com/ http://aew.werc.ewr/?ad=qwe&dw 1aew.werc.ewr/?ad=qwe&dw 2aew.werc.ewr http://3aew.werc.ewr/?ad=qwe&dw http://4aew.werc.ewr http://5aew.werc.ewr:8100/?  ad=qwe&dw 6aew.werc.ewr:8100/?ad=qwe&dw 7aew.werc.ewr:8100/?ad=qwe&dw=%20%32 +4.0e-10 qwe qwe qwqwe 234.435 455 5.005 teodor@stack.net teodor@123-stack.net 123_teodor@stack.net 123-teodor@stack.net qwe-wer asdf <fr>qwer jf sdjk<we hjwer <werrwe> ewr1> ewri2 <a href="qwe<qwe>">
/usr/local/fff /awdf/dwqe/4325 rewt/ewr wefjn /wqe-324/ewr gist.h gist.h.c gist.c. readline 4.2 4.2. 4.2, readline-4.2 readline-4.2. 234
<i <b> wow  < jqw <> qwerty');
SELECT to_tsvector('english', '345 qwe@efd.r '' http://www.com/ http://aew.werc.ewr/?ad=qwe&dw 1aew.werc.ewr/?ad=qwe&dw 2aew.werc.ewr http://3aew.werc.ewr/?ad=qwe&dw http://4aew.werc.ewr http://5aew.werc.ewr:8100/?  ad=qwe&dw 6aew.werc.ewr:8100/?ad=qwe&dw 7aew.werc.ewr:8100/?ad=qwe&dw=%20%32 +4.0e-10 qwe qwe qwqwe 234.435 455 5.005 teodor@stack.net teodor@123-stack.net 123_teodor@stack.net 123-teodor@stack.net qwe-wer asdf <fr>qwer jf sdjk<we hjwer <werrwe> ewr1> ewri2 <a href="qwe<qwe>">
/usr/local/fff /awdf/dwqe/4325 rewt/ewr wefjn /wqe-324/ewr gist.h gist.h.c gist.c. readline 4.2 4.2. 4.2, readline-4.2 readline-4.2. 234
<i <b> wow  < jqw <> qwerty');
SELECT length(to_tsvector('english', '345 qwe@efd.r '' http://www.com/ http://aew.werc.ewr/?ad=qwe&dw 1aew.werc.ewr/?ad=qwe&dw 2aew.werc.ewr http://3aew.werc.ewr/?ad=qwe&dw http://4aew.werc.ewr http://5aew.werc.ewr:8100/?  ad=qwe&dw 6aew.werc.ewr:8100/?ad=qwe&dw 7aew.werc.ewr:8100/?ad=qwe&dw=%20%32 +4.0e-10 qwe qwe qwqwe 234.435 455 5.005 teodor@stack.net teodor@123-stack.net 123_teodor@stack.net 123-teodor@stack.net qwe-wer asdf <fr>qwer jf sdjk<we hjwer <werrwe> ewr1> ewri2 <a href="qwe<qwe>">
/usr/local/fff /awdf/dwqe/4325 rewt/ewr wefjn /wqe-324/ewr gist.h gist.h.c gist.c. readline 4.2 4.2. 4.2, readline-4.2 readline-4.2. 234
<i <b> wow  < jqw <> qwerty'));
SELECT * from ts_debug('english', 'http://www.harewoodsolutions.co.uk/press.aspx</span>');
SELECT to_tsquery('english', 'qwe & sKies ');
SELECT plainto_tsquery('english', 'the and z 1))& fghj');
SELECT plainto_tsquery('english', 'foo bar') && plainto_tsquery('english', 'asd');
SELECT plainto_tsquery('english', 'foo bar') || plainto_tsquery('english', 'asd fg');
SELECT plainto_tsquery('english', 'foo bar') && 'asd | fg';
SELECT phraseto_tsquery('english', 'PostgreSQL can be extended by the user in many ways');
SELECT ts_rank_cd(strip(to_tsvector('both stripped')),
                  to_tsquery('both & stripped'));
SELECT ts_headline('english',
'Lorem ipsum urna.  Nullam nullam ullamcorper urna.',
to_tsquery('english','Lorem') && phraseto_tsquery('english','ullamcorper urna'),
'MaxWords=100, MinWords=1');
CREATE TABLE test_tsquery (txtkeyword TEXT, txtsample TEXT);
ALTER TABLE test_tsquery ADD COLUMN sample tsquery;
UPDATE test_tsquery SET sample = to_tsquery('english', txtsample::text);
SET enable_seqscan=OFF;
RESET enable_seqscan;
SELECT ts_rewrite('foo & bar & qq & new & york',  'new & york'::tsquery, 'big & apple | nyc | new & york & city');
SET enable_seqscan=OFF;
SELECT to_tsvector('foo bar') @@
  ts_rewrite(tsquery_phrase('foo', 'foo'), 'foo', 'bar | baz');
SELECT to_tsvector('bar baz') @@
  ts_rewrite(tsquery_phrase('foo', 'foo'), 'foo', 'bar | baz');
RESET enable_seqscan;
SET default_text_search_config=simple;
SET default_text_search_config=english;
CREATE TRIGGER tsvectorupdate
BEFORE UPDATE OR INSERT ON test_tsvector
FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger(a, 'pg_catalog.english', t);
INSERT INTO test_tsvector (t) VALUES ('345 qwerty');
UPDATE test_tsvector SET t = null WHERE t = '345 qwerty';
INSERT INTO test_tsvector (t) VALUES ('345 qwerty');
explain (costs off)
select * from test_tsquery, to_tsquery('new') q where txtsample @@ q;
explain (costs off)
select * from test_tsquery, to_tsquery('english', 'new') q where txtsample @@ q;
create temp table pendtest (ts tsvector);
create index pendtest_idx on pendtest using gin(ts);
insert into pendtest values (to_tsvector('Lore ipsam'));
insert into pendtest values (to_tsvector('Lore ipsum'));
select * from pendtest where 'ipsu:*'::tsquery @@ ts;
select * from pendtest where 'ipsa:*'::tsquery @@ ts;
select * from pendtest where 'ips:*'::tsquery @@ ts;
select * from pendtest where 'ipt:*'::tsquery @@ ts;
select * from pendtest where 'ipi:*'::tsquery @@ ts;
create temp table phrase_index_test(fts tsvector);
insert into phrase_index_test values ('A fat cat has just eaten a rat.');
insert into phrase_index_test values (to_tsvector('english', 'A fat cat has just eaten a rat.'));
create index phrase_index_test_idx on phrase_index_test using gin(fts);
set enable_seqscan = off;
select * from phrase_index_test where fts @@ phraseto_tsquery('english', 'fat cat');
set enable_seqscan = on;
select websearch_to_tsquery('simple', 'I have a fat:*ABCD cat');
select to_tsvector('english', 'A fat cat ate a rat') @@
	websearch_to_tsquery('english', '"a fat cat" ate a rat');
select to_tsvector('english', 'A fat grey cat ate a rat') @@
	websearch_to_tsquery('english', '"a fat cat" ate a rat');
