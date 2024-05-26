DROP TABLE IF EXISTS dep;
DROP TABLE IF EXISTS dep2;
DROP TABLE IF EXISTS id_join;
CREATE TABLE id_join (`country` String, `location` Array(Int32)) ENGINE = Join(ANY, LEFT, country);
INSERT INTO id_join values ('CLICK', [1234]);
