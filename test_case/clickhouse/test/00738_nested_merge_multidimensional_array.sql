SYSTEM STOP MERGES sites;
INSERT INTO sites VALUES (1,[1],[[]]);
INSERT INTO sites VALUES (2,[1],[['2018-06-22']]);
SELECT count(), countArray(Users.Dates), countArrayArray(Users.Dates) FROM sites;
SYSTEM START MERGES sites;
OPTIMIZE TABLE sites FINAL;
DROP TABLE sites;
