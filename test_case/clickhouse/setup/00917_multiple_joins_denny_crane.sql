SET joined_subquery_requires_alias = 0;
DROP TABLE IF EXISTS ANIMAL;
CREATE TABLE ANIMAL ( ANIMAL Nullable(String) ) engine = TinyLog;
INSERT INTO ANIMAL (ANIMAL) VALUES ('CAT'), ('FISH'), ('DOG'), ('HORSE'), ('BIRD');
