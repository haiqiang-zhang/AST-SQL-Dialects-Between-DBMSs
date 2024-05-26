SELECT any(acctstatustype = 'Stop') FROM radacct WHERE (acctstatustype = 'Stop') AND ((acctinputoctets + acctoutputoctets) > 0);
create materialized view mv_traffic_by_tadig15min Engine=AggregatingMergeTree partition by tadig order by (ts,tadig) populate as select toStartOfFifteenMinutes(timestamp) ts,toDayOfWeek(timestamp) dow, tadig, sumState(acctinputoctets+acctoutputoctets) traffic_bytes,maxState(timestamp) last_stop, minState(radacctid) min_radacctid,maxState(radacctid) max_radacctid from radacct where acctstatustype='Stop' and acctinputoctets+acctoutputoctets > 0 group by tadig,ts,dow;
select tadig, ts, dow, sumMerge(traffic_bytes), maxMerge(last_stop), minMerge(min_radacctid), maxMerge(max_radacctid) from mv_traffic_by_tadig15min group by tadig, ts, dow;
drop table if exists radacct;
drop table if exists mv_traffic_by_tadig15min;
