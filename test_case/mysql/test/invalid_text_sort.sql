DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (
    tx TEXT CHARACTER SET utf8mb3 NULL,
    pk INTEGER AUTO_INCREMENT,
    PRIMARY KEY (pk)
) ENGINE=myisam;

INSERT INTO t1 VALUES
(
    'valid-string',
    NULL
)
,
(
    UNHEX('FF'),
    NULL
)
;

SELECT pk,OCTET_LENGTH(tx),LENGTH(tx) FROM t1;

SELECT tx FROM t1 ORDER BY tx DESC;

DROP TABLE t1;