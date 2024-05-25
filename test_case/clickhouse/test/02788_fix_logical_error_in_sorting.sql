SYSTEM STOP MERGES session_events;
SYSTEM STOP MERGES event_types;
INSERT INTO session_events SELECT
    141,
    '693de636-6d9b-47b7-b52a-33bd303b6255',
    1686053240314,
    number,
    number,
    toString(number % 10),
    ''
FROM numbers_mt(100000);
INSERT INTO session_events SELECT
    141,
    '693de636-6d9b-47b7-b52a-33bd303b6255',
    1686053240314,
    number,
    number,
    toString(number % 10),
    ''
FROM numbers_mt(100000);
INSERT INTO event_types SELECT
    toString(number % 10),
    number % 2
FROM numbers(20);
SET optimize_sorting_by_input_stream_properties = 1;
DROP TABLE session_events;
DROP TABLE event_types;
