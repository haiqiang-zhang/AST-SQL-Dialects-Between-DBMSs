set optimizer_switch='block_nested_loop=on';

if (`select locate('mrr_cost_based', @@optimizer_switch) > 0`) 
{
  set optimizer_switch='mrr_cost_based=off';

set optimizer_switch = default;