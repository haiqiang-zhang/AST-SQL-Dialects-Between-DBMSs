SET allow_experimental_analyzer=1;
select 1 as `c0`
from (
        select C.`ÃÂ¥ÃÂ­ÃÂÃÂ¦ÃÂ®ÃÂµ` AS `ÃÂ¥ÃÂ­ÃÂÃÂ¦ÃÂ®ÃÂµ`
        from (
                select 2 as bb
            ) A
            LEFT JOIN (
                select '1' as `ÃÂ¥ÃÂ­ÃÂÃÂ¦ÃÂ®ÃÂµ`
            ) C ON 1 = 1
            LEFT JOIN (
                select 1 as a
            ) D ON 1 = 1
    ) as `T0`
where `T0`.`ÃÂ¥ÃÂ­ÃÂÃÂ¦ÃÂ®ÃÂµ` = '1';
select 1 as `c0`
from (
        select C.`ÃÂ¯ÃÂ¼ÃÂ` AS `ÃÂ¯ÃÂ¼ÃÂ`
        from (
                select 2 as bb
            ) A
            LEFT JOIN (
                select '1' as `ÃÂ¯ÃÂ¼ÃÂ`
            ) C ON 1 = 1
            LEFT JOIN (
                select 1 as a
            ) D ON 1 = 1
    ) as `T0`
where `T0`.`ÃÂ¯ÃÂ¼ÃÂ` = '1';
