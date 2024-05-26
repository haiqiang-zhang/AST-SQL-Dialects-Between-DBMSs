SELECT CURRENT_USER(), CURRENT_ROLE();
SELECT ExtractValue(ROLES_GRAPHML(),'count(//node)') as num_nodes;
SELECT ExtractValue(ROLES_GRAPHML(),'count(//edge)') as num_edges;
DROP DATABASE db1;
DROP DATABASE db2;
CREATE DATABASE db1;
DROP DATABASE db1;
