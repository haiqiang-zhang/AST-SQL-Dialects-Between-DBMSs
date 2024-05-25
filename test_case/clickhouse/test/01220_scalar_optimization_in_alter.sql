alter table cdp_segments update mid_seqs = bitmapOr(mid_seqs, (select groupBitmapState(mid_seq) from cdp_customers where mid in ('6bf3c2ee-2b33-3030-9dc2-25c6c618d141'))) where seg_id = '1234567890';
drop table cdp_segments;
drop table cdp_customers;
