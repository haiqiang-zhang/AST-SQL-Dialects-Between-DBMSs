SELECT size, pg_size_pretty(size), pg_size_pretty(-1 * size) FROM
    (VALUES (10::bigint), (1000::bigint), (1000000::bigint),
            (1000000000::bigint), (1000000000000::bigint),
            (1000000000000000::bigint)) x(size);
SELECT size, pg_size_bytes(size) FROM
    (VALUES ('1'), ('123bytes'), ('256 B'), ('1kB'), ('1MB'), (' 1 GB'), ('1.5 GB '),
            ('1TB'), ('3000 TB'), ('1e6 MB'), ('99 PB')) x(size);
