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
