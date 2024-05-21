CREATE TABLE customer (
       cid      int primary key,
       name     text not null,
       tel      text,
       passwd	text
);
CREATE TABLE credit_card (
       cid      int references customer(cid),
       cnum     text,
       climit   int
);
CREATE TABLE credit_usage (
       cid      int references customer(cid),
       ymd      date,
       usage    int
);
INSERT INTO customer
       VALUES (101, 'regress_alice', '+81-12-3456-7890', 'passwd123'),
              (102, 'regress_bob',   '+01-234-567-8901', 'beafsteak'),
              (103, 'regress_eve',   '+49-8765-43210',   'hamburger');
INSERT INTO credit_card
       VALUES (101, '1111-2222-3333-4444', 4000),
              (102, '5555-6666-7777-8888', 3000),
              (103, '9801-2345-6789-0123', 2000);
INSERT INTO credit_usage
       VALUES (101, '2011-09-15', 120),
	      (101, '2011-10-05',  90),
	      (101, '2011-10-18', 110),
	      (101, '2011-10-21', 200),
	      (101, '2011-11-10',  80),
	      (102, '2011-09-22', 300),
	      (102, '2011-10-12', 120),
	      (102, '2011-10-28', 200),
	      (103, '2011-10-15', 480);
CREATE VIEW my_property_normal AS
       SELECT * FROM customer WHERE name = current_user;
CREATE VIEW my_property_secure WITH (security_barrier) AS
       SELECT * FROM customer WHERE name = current_user;
CREATE VIEW my_credit_card_normal AS
       SELECT * FROM customer l NATURAL JOIN credit_card r
       WHERE l.name = current_user;
CREATE VIEW my_credit_card_secure WITH (security_barrier) AS
       SELECT * FROM customer l NATURAL JOIN credit_card r
       WHERE l.name = current_user;
CREATE VIEW my_credit_card_usage_normal AS
       SELECT * FROM my_credit_card_secure l NATURAL JOIN credit_usage r;
CREATE VIEW my_credit_card_usage_secure WITH (security_barrier) AS
       SELECT * FROM my_credit_card_secure l NATURAL JOIN credit_usage r;
GRANT SELECT ON my_property_normal TO public;
GRANT SELECT ON my_property_secure TO public;
GRANT SELECT ON my_credit_card_normal TO public;
GRANT SELECT ON my_credit_card_secure TO public;
GRANT SELECT ON my_credit_card_usage_normal TO public;
GRANT SELECT ON my_credit_card_usage_secure TO public;
RESET SESSION AUTHORIZATION;
ALTER VIEW my_property_normal SET (security_barrier=true);
ALTER VIEW my_property_secure SET (security_barrier=false);
RESET SESSION AUTHORIZATION;
