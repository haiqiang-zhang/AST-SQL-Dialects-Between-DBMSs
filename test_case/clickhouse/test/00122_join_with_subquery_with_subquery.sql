SELECT k FROM (SELECT 1 AS k FROM system.one) js1 ANY LEFT JOIN (SELECT k FROM (SELECT 1 AS k, 2 AS x)) js2 USING k;