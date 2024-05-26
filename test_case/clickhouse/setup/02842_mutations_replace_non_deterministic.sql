DROP TABLE IF EXISTS t_mutations_nondeterministic SYNC;
SET mutations_sync = 2;
SET mutations_execute_subqueries_on_initiator = 1;
SET mutations_execute_nondeterministic_on_initiator = 1;
