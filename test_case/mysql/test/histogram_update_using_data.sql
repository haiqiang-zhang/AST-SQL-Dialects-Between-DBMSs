
CREATE TABLE tbl_int(col1 INT);
INSERT INTO tbl_int VALUES (4), (52), (12), (12), (4), (23), (NULL), (NULL);
let $json_data= {"buckets": [[4, 0.25], [12, 0.5], [23, 0.625], [52, 0.75]], "data-type": "int", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 4};

-- Test case arrangements:
--
--   Common cases
--
--   - common single attribute: missing, dom type, value domain
--
--   Each histogram type
--
--   - data type attribute
--   - buckets: missing, dom type
--   - number of buckets
--   - buckets: bucket layout
--
--   - bucket frequency: dom type, value domain
--   - frequency sequence and total frequency
--
--   Each value type
--
--   - bucket endpoint: dom type, value domain
--   - endpoint sequence

--echo --
--echo -- check attribute data-type
--echo --
ANALYZE TABLE tbl_int UPDATE HISTOGRAM ON col1 USING DATA '{"buckets": [[4, 0.25], [12, 0.5], [23, 0.625], [52, 0.75]], "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 4}';

DROP TABLE tbl_int;

CREATE TABLE tbl_int(col1 INT);
INSERT INTO tbl_int VALUES (4), (52), (12), (12), (4), (23);
let $json_data= {"buckets": [[4, 4, 0.3333333333333333, 1], [12, 12, 0.6666666666666666, 1], [23, 52, 1.0, 2]], "data-type": "int", "null-values": 0.0, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 3};

DROP TABLE tbl_int;

CREATE TABLE tbl_uint(col1 BIGINT UNSIGNED);
INSERT INTO tbl_uint VALUES (4), (52), (12), (12), (4), (23), (NULL), (NULL);
let $json_data= {"buckets": [[4, 0.25], [12, 0.5], [23, 0.625], [52, 0.75]], "data-type": "uint", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 4};

DROP TABLE tbl_uint;

CREATE TABLE tbl_uint(col1 BIGINT UNSIGNED);
INSERT INTO tbl_uint VALUES (4), (52), (12), (12), (4), (23), (NULL), (NULL);
let $json_data= {"buckets": [[4, 4, 0.25, 1], [12, 12, 0.5, 1], [23, 52, 0.75, 2]], "data-type": "uint", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 3};

DROP TABLE tbl_uint;

CREATE TABLE tbl_double(col1 DOUBLE);
INSERT INTO tbl_double VALUES (4.0), (52.0), (12.0), (12.0), (4.0), (23.0), (NULL), (NULL);
let $json_data= {"buckets": [[4.0, 0.25], [12.0, 0.5], [23.0, 0.625], [52.0, 0.75]], "data-type": "double", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 4};

DROP TABLE tbl_double;

CREATE TABLE tbl_double(col1 DOUBLE);
INSERT INTO tbl_double VALUES (4.0), (52.0), (12.0), (12.0), (4.0), (23.0), (NULL), (NULL);
let $json_data= {"buckets": [[4.0, 4.0, 0.25, 1], [12.0, 12.0, 0.5, 1], [23.0, 52.0, 0.75, 2]], "data-type": "double", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 3};

DROP TABLE tbl_double;

CREATE TABLE tbl_string(col1 VARCHAR(8));
INSERT INTO tbl_string VALUES ("Charles"), ("Mark"), ("Bill"), ("Bill"), ("Charles"), ("Vincent"), (NULL), (NULL);
let $json_data= {"buckets": [["base64:type254:QmlsbA==", 0.25], ["base64:type254:Q2hhcmxlcw==", 0.5], ["base64:type254:TWFyaw==", 0.625], ["base64:type254:VmluY2VudA==", 0.75]], "data-type": "string", "null-values": 0.25, "collation-id": 255, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 4};

DROP TABLE tbl_string;

CREATE TABLE tbl_string(col1 VARCHAR(8));
INSERT INTO tbl_string VALUES ("Charles"), ("Mark"), ("Bill"), ("Bill"), ("Charles"), ("Vincent"), (NULL), (NULL);
let $json_data= {"buckets": [["base64:type254:QmlsbA==", "base64:type254:QmlsbA==", 0.25, 1], ["base64:type254:Q2hhcmxlcw==", "base64:type254:Q2hhcmxlcw==", 0.5, 1], ["base64:type254:TWFyaw==", "base64:type254:VmluY2VudA==", 0.75, 2]], "data-type": "string", "null-values": 0.25, "collation-id": 255, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 3};

DROP TABLE tbl_string;

CREATE TABLE tbl_date(col1 DATE);
INSERT INTO tbl_date VALUES ("2018-03-21"), ("2017-02-06"), ("2017-02-10"), ("2017-02-10"), ("2018-03-21"), ("2018-02-12"), (NULL), (NULL);
let $json_data= {"buckets": [["2017-02-06", 0.125], ["2017-02-10", 0.375], ["2018-02-12", 0.5], ["2018-03-21", 0.75]], "data-type": "date", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 4};

DROP TABLE tbl_date;

CREATE TABLE tbl_date(col1 DATE);
INSERT INTO tbl_date VALUES ("2018-03-21"), ("2017-02-06"), ("2017-02-10"), ("2017-02-10"), ("2018-03-21"), ("2018-02-12"), (NULL), (NULL);
let $json_data= {"buckets": [["2017-02-06", "2017-02-10", 0.375, 2], ["2018-02-12", "2018-02-12", 0.5, 1], ["2018-03-21", "2018-03-21", 0.75, 1]], "data-type": "date", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 3};

DROP TABLE tbl_date;

CREATE TABLE tbl_time(col1 TIME);
INSERT INTO tbl_time VALUES ("21:12:42"), ("16:22:23"), ("08:15:18"), ("08:15:18"), ("21:12:42"), ("07:04:18"), (NULL), (NULL);
let $json_data= {"buckets": [["07:04:18.000000", 0.125], ["08:15:18.000000", 0.375], ["16:22:23.000000", 0.5], ["21:12:42.000000", 0.75]], "data-type": "time", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 4};

DROP TABLE tbl_time;

CREATE TABLE tbl_time(col1 TIME);
INSERT INTO tbl_time VALUES ("21:12:42"), ("16:22:23"), ("08:15:18"), ("08:15:18"), ("21:12:42"), ("07:04:18"), (NULL), (NULL);
let $json_data= {"buckets": [["07:04:18.000000", "08:15:18.000000", 0.375, 2], ["16:22:23.000000", "16:22:23.000000", 0.5, 1], ["21:12:42.000000", "21:12:42.000000", 0.75, 1]], "data-type": "time", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 3};

DROP TABLE tbl_time;

CREATE TABLE tbl_datetime(col1 DATETIME);
INSERT INTO tbl_datetime VALUES ("2018-03-21 21:12:42"), ("2017-02-06 16:22:23"), ("2017-02-10 08:15:18"), ("2017-02-10 08:15:18"), ("2018-03-21 21:12:42"), ("2018-02-12 07:04:18"), (NULL), (NULL);
let $json_data= {"buckets": [["2017-02-06 16:22:23.000000", 0.125], ["2017-02-10 08:15:18.000000", 0.375], ["2018-02-12 07:04:18.000000", 0.5], ["2018-03-21 21:12:42.000000", 0.75]], "data-type": "datetime", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 4};

DROP TABLE tbl_datetime;

CREATE TABLE tbl_datetime(col1 DATETIME);
INSERT INTO tbl_datetime VALUES ("2018-03-21 21:12:42"), ("2017-02-06 16:22:23"), ("2017-02-10 08:15:18"), ("2017-02-10 08:15:18"), ("2018-03-21 21:12:42"), ("2018-02-12 07:04:18"), (NULL), (NULL);
let $json_data= {"buckets": [["2017-02-06 16:22:23.000000", "2017-02-10 08:15:18.000000", 0.375, 2], ["2018-02-12 07:04:18.000000", "2018-02-12 07:04:18.000000", 0.5, 1], ["2018-03-21 21:12:42.000000", "2018-03-21 21:12:42.000000", 0.75, 1]], "data-type": "datetime", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 3};

DROP TABLE tbl_datetime;

-- Note: This numbers are crafted carefully to avoid kind of 4.00,
--       the direct-write way does not preserve trailing zeros.

CREATE TABLE tbl_decimal(col1 DECIMAL(5,2));
INSERT INTO tbl_decimal VALUES (4.12), (52.12), (12.12), (12.12), (4.12), (23.12), (NULL), (NULL);
let $json_data= {"buckets": [[4.12, 0.25], [12.12, 0.5], [23.12, 0.625], [52.12, 0.75]], "data-type": "decimal", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 4};

DROP TABLE tbl_decimal;

CREATE TABLE tbl_decimal(col1 DECIMAL(5,2));
INSERT INTO tbl_decimal VALUES (4.12), (52.12), (12.12), (12.12), (4.12), (23.12), (NULL), (NULL);
let $json_data= {"buckets": [[4.12, 4.12, 0.25, 1], [12.12, 12.12, 0.5, 1], [23.12, 52.12, 0.75, 2]], "data-type": "decimal", "null-values": 0.25, "collation-id": 8, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 3};

DROP TABLE tbl_decimal;

CREATE TABLE tbl_enum (col1 ENUM('red', 'black', 'blue', 'green'));
INSERT INTO tbl_enum VALUES ('red'), ('red'), ('black'), ('blue'), ('green'),
                            ('green'), (NULL), (NULL), (NULL), (NULL);
let $json_data= {"buckets": [[1, 0.2], [2, 0.3], [3, 0.4], [4, 0.6]], "data-type": "enum", "null-values": 0.4, "collation-id": 255, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 10};

let $json_data= {"buckets": [[1, 2, 0.3, 2], [3, 4, 0.6, 2]], "data-type": "enum", "null-values": 0.4, "collation-id": 255, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 2};

DROP TABLE tbl_enum;

CREATE TABLE tbl_set (col1 SET('red', 'black', 'blue', 'green'));
INSERT INTO tbl_set VALUES ('red'), ('red,black'), ('black,green,blue'),
                           ('black,green,blue'), ('black,green,blue'),
                           ('green'), ('green,red'), ('red,green'),
                           (NULL), (NULL);
let $json_data= {"buckets": [[1, 0.1], [3, 0.2], [8, 0.3], [9, 0.5], [14, 0.8]], "data-type": "set", "null-values": 0.2, "collation-id": 255, "sampling-rate": 1.0, "histogram-type": "singleton", "number-of-buckets-specified": 10};

let $json_data= {"buckets": [[1, 9, 0.5, 4], [14, 14, 0.8, 1]], "data-type": "set", "null-values": 0.2, "collation-id": 255, "sampling-rate": 1.0, "histogram-type": "equi-height", "number-of-buckets-specified": 2};

DROP TABLE tbl_set;
