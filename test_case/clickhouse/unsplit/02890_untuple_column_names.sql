
-- result column names and confuse query analysis (see #26179), test also two untuple() calls in one SElECT
-- with the same types and aliases.

SELECT '-- tuple element alias';
SELECT '-- tuple element alias + untuple() alias';
SELECT '-- untuple() alias';
SELECT '-- no aliases';
SELECT '-- tuple() loses the column names (would be good to fix, see #36773)';
SELECT '-- thankfully JSONExtract() keeps them';
