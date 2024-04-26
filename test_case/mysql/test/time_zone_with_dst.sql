
SET time_zone = 'CET';

CREATE TABLE ts1 ( a TIMESTAMP );
CREATE TABLE dt1 ( a DATETIME );

CREATE TABLE ts2 ( a TIMESTAMP );
CREATE TABLE dt2 ( a DATETIME );

CREATE TABLE ts3 ( a TIMESTAMP );
CREATE TABLE dt3 ( a DATETIME );

CREATE TABLE ts4 ( a TIMESTAMP );
CREATE TABLE dt4 ( a DATETIME );

INSERT INTO ts1 VALUES ('2018-10-28 00:30:00+00:00'),
                       ('2018-10-28 00:59:00+00:00'),
                       ('2018-10-28 01:00:00+00:00'),
                       ('2018-10-28 01:30:00+00:00');

SELECT * FROM ts1;

INSERT INTO dt1 VALUES ('2018-10-28 00:30:00+00:00'),
                       ('2018-10-28 00:59:00+00:00'),
                       ('2018-10-28 01:00:00+00:00'),
                       ('2018-10-28 01:30:00+00:00');

SELECT * FROM dt1;

INSERT INTO ts2 VALUES ('2018-10-28 00:30:00+12:34'),
                       ('2018-10-28 00:59:00+12:34'),
                       ('2018-10-28 01:00:00+12:34'),
                       ('2018-10-28 01:30:00+12:34');

SELECT * FROM ts2;

INSERT INTO dt2 VALUES ('2018-10-28 00:30:00+12:34'),
                       ('2018-10-28 00:59:00+12:34'),
                       ('2018-10-28 01:00:00+12:34'),
                       ('2018-10-28 01:30:00+12:34');

SELECT * FROM dt2;

INSERT INTO ts3 VALUES ('2018-10-27 23:06:00-01:24'),
                       ('2018-10-27 23:06:00-01:53'),
                       ('2018-10-27 23:06:00-01:54'),
                       ('2018-10-27 23:06:00-02:24');

SELECT * FROM ts3;

INSERT INTO dt3 VALUES ('2018-10-27 23:06:00-01:24'),
                       ('2018-10-27 23:06:00-01:53'),
                       ('2018-10-27 23:06:00-01:54'),
                       ('2018-10-27 23:06:00-02:24');

SELECT * FROM dt3;

INSERT INTO ts4 VALUES ('2019-03-31 00:30:00+00:00'),
                       ('2019-03-31 00:59:00+00:00'),
                       ('2019-03-31 01:00:00+00:00'),
                       ('2019-03-31 01:30:00+00:00');

SELECT * FROM ts4;

INSERT INTO dt4 VALUES ('2019-03-31 00:30:00+00:00'),
                       ('2019-03-31 00:59:00+00:00'),
                       ('2019-03-31 01:00:00+00:00'),
                       ('2019-03-31 01:30:00+00:00');

SELECT * FROM dt4;

DROP TABLE ts1, dt1, ts2, dt2, ts3, dt3, ts4, dt4;

SET time_zone = DEFAULT;
