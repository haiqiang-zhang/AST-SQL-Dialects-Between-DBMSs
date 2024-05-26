CREATE DOMAIN sqljsonb_int_not_null AS int NOT NULL;
CREATE TYPE rainbow AS ENUM ('red', 'orange', 'yellow', 'green', 'blue', 'purple');
CREATE DOMAIN rgb AS rainbow CHECK (VALUE IN ('red', 'green', 'blue'));
CREATE TYPE comp_abc AS (a text, b int, c timestamp);
DROP TYPE comp_abc;
CREATE TYPE sqljsonb_rec AS (a int, t text, js json, jb jsonb, jsa json[]);
CREATE TYPE sqljsonb_reca AS (reca sqljsonb_rec[]);
