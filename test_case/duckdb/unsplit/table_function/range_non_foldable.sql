PRAGMA enable_verification;
SELECT to_timestamp(range) as entry
    FROM range(
      epoch(date_trunc('month', current_date))::BIGINT,
      epoch(date_trunc('month', current_date) + interval '1 month' - interval '1 day')::BIGINT,
      epoch(interval '1 day')::BIGINT
    );
SELECT to_timestamp(range) as entry
FROM range(
  epoch(date_trunc('month', current_date))::BIGINT,
  epoch(date_trunc('month', current_date) + interval '1 month' - interval '1 day')::BIGINT,
  epoch(interval '1 day')::BIGINT
);
SELECT COUNT(*)
FROM range(
  current_date,
  current_date + interval '7' days,
  interval '1 day'
);
