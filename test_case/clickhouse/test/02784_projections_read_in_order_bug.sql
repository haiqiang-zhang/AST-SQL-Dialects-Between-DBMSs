set read_in_order_two_level_merge_threshold=1;
SELECT id, timestamp, payload FROM events WHERE (organisation_id = reinterpretAsUUID(1)) AND (session_id = reinterpretAsUUID(0)) ORDER BY timestamp, payload, id ASC;
