-- 
-- Run join_outer.test with BKA enabled 
--
set optimizer_switch='batched_key_access=on,mrr_cost_based=off';

set optimizer_switch=default;
