create materialized view mv to data as select key, uniqExact(value) uniq_values from ephemeral group by key;
system stop distributed sends dist_in;
set prefer_localhost_replica=0;
