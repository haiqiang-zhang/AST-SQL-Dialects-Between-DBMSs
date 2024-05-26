SELECT count() FROM count;
SELECT count() * 2 FROM count;
SELECT arrayJoin([count(), count()]) FROM count;
SELECT arrayJoin([count(), count()]) AS x FROM count LIMIT 1 BY x;
SELECT arrayJoin([count(), count() + 1]) AS x FROM count LIMIT 1 BY x;
DROP TABLE count;
