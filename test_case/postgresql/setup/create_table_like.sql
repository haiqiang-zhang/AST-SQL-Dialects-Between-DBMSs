CREATE TABLE inhx (xx text DEFAULT 'text');
CREATE TABLE ctla (aa TEXT);
CREATE TABLE ctlb (bb TEXT) INHERITS (ctla);
CREATE TABLE inhe (ee text, LIKE inhx) inherits (ctlb);
INSERT INTO inhe VALUES ('ee-col1', 'ee-col2', DEFAULT, 'ee-col4');
