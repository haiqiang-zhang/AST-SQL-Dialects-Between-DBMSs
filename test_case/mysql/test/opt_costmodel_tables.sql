CREATE TABLE server_cost_tmp (
  cost_name VARCHAR(64) NOT NULL,
  last_update TIMESTAMP
);
CREATE TABLE engine_cost_tmp (
  cost_name VARCHAR(64) NOT NULL,
  last_update TIMESTAMP
);
DROP TABLE server_cost_tmp, engine_cost_tmp;
