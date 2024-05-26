SELECT * FROM persons;
CREATE FUNCTION get_all_persons() RETURNS SETOF person_type
LANGUAGE SQL
AS $$
    SELECT * FROM persons;
$$;
SELECT * FROM get_all_persons();
CREATE TABLE stuff (id int);
CREATE TABLE persons2 OF person_type (
    id WITH OPTIONS PRIMARY KEY,
    UNIQUE (name)
);
CREATE TABLE persons3 OF person_type (
    PRIMARY KEY (id),
    name WITH OPTIONS DEFAULT ''
);
DROP TYPE person_type CASCADE;
DROP TABLE stuff;
CREATE TYPE person_type AS (id int, name text);
CREATE TABLE persons OF person_type;
INSERT INTO persons VALUES (1, 'test');
CREATE FUNCTION namelen(person_type) RETURNS int LANGUAGE SQL AS $$ SELECT length($1.name) $$;
SELECT id, namelen(persons) FROM persons;
CREATE TABLE persons2 OF person_type (
    id WITH OPTIONS PRIMARY KEY,
    UNIQUE (name)
);
CREATE TABLE persons3 OF person_type (
    PRIMARY KEY (id),
    name NOT NULL DEFAULT ''
);
