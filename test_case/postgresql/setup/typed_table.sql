CREATE TYPE person_type AS (id int, name text);
CREATE TABLE persons OF person_type;
CREATE TABLE IF NOT EXISTS persons OF person_type;
