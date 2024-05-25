SET force_primary_key = 1;
SELECT count() FROM mt_match_pk WHERE match(v, '^a');
SELECT count() FROM mt_match_pk WHERE match(v, '^ab');
SELECT count() FROM mt_match_pk WHERE match(v, '^a.');
SELECT count() FROM mt_match_pk WHERE match(v, '^ab*');
SELECT count() FROM mt_match_pk WHERE match(v, '^ac?');
