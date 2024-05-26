DROP TABLE IF EXISTS session_events;
DROP TABLE IF EXISTS event_types;
CREATE TABLE session_events
(
    clientId UInt64,
    sessionId String,
    pageId UInt64,
    eventNumber UInt64,
    timestamp UInt64,
    type LowCardinality(String),
    data String
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(toDate(pageId / 1000))
ORDER BY (clientId, sessionId, pageId, timestamp);
CREATE TABLE event_types
(
    type String,
    active Int16
)
ENGINE = MergeTree
PARTITION BY substring(type, 1, 1)
ORDER BY (type, active);
