
CREATE RESOURCE GROUP rg1 TYPE=USER VCPU=0;
SET RESOURCE GROUP rg1;
SET DEBUG='+d,make_sure_cpu_affinity_is_dropped';
DROP RESOURCE GROUP rg1 FORCE;
SET DEBUG='-d,make_sure_cpu_affinity_is_dropped';
