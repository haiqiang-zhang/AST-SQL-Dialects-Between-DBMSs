SET default_null_order='nulls_first';;
CREATE TABLE strings(a VARCHAR);
CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (3), (4), (NULL);
INSERT INTO strings SELECT * FROM integers;
UPDATE strings SET a=13 WHERE a='3';
SELECT * FROM strings;
SELECT * FROM strings ORDER BY cast(a AS INTEGER);
