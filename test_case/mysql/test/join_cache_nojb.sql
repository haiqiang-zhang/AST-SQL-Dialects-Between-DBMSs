
set optimizer_switch='block_nested_loop=off,batched_key_access=off';

if (`select locate('mrr_cost_based', @@optimizer_switch) > 0`) 
{
  set optimizer_switch='mrr_cost_based=off';

set optimizer_switch = default;
