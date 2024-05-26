SELECT count() FROM data WHERE str NOT LIKE 'a%' SETTINGS force_primary_key=1;
