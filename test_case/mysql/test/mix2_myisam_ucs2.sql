
--
-- Tests which require ucs2 character set and myisam engine
--
--source include/force_myisam_default.inc
--source include/have_myisam.inc

let $engine_type= MyISAM;
let $other_engine_type= MEMORY;
let $other_engine_type1= MEMORY;
let $other_non_trans_engine_type= MEMORY;
let $other_non_live_chks_engine_type= MEMORY;
let $other_live_chks_engine_type= MyISAM;
let $test_transactions= 0;
let $test_foreign_keys= 0;
let $fulltext_query_unsupported= 0;
let $no_autoinc_update= 0;
let $no_spatial_key= 0;
