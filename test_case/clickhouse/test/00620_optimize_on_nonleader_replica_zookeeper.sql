-- Tag no-replicated-database: Fails due to additional replicas or shards

-- The test is mostly outdated as now every replica is leader and can do OPTIMIZE locally.

DROP TABLE IF EXISTS rename1;
DROP TABLE IF EXISTS rename2;
DROP TABLE IF EXISTS rename3;
DROP TABLE IF EXISTS rename1;
DROP TABLE IF EXISTS rename2;
DROP TABLE IF EXISTS rename3;
