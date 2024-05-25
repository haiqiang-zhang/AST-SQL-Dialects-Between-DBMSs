CREATE MATERIALIZED VIEW t_mv_00751 ENGINE = MergeTree ORDER BY date
    AS SELECT date, platform, app FROM t_00751
    WHERE app = (SELECT min(app) from u_00751) AND platform = (SELECT (SELECT min(platform) from v_00751));
USE default;
