SELECT hex(a) ha, hex(lower(a)) hl, hex(upper(a)) hu
from t1 order by ha;
SELECT HEX(group_concat(a collate latin2_croatian_ci order by binary a)) from t1 group by a collate latin2_croatian_ci;
drop table t1;
