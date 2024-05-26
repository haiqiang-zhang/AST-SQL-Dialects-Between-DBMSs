CREATE TYPE greeting AS ENUM('hi', 'bonjour', 'konnichiwa', 'howdy');
CREATE TABLE integral_values (
    j smallint,
    k integer,
    l bigint,
    i real,
    z double precision,
    m DECIMAL(4, 1),
    n DECIMAL(9, 2),
    o DECIMAL(18, 4),
    p DECIMAL(37, 2),
    q varchar,
    r bytea,
    s date,
    t time,
    u timestamp,
	v date[],
	w greeting
);
CREATE SEQUENCE seq;
