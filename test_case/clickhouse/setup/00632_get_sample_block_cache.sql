SET joined_subquery_requires_alias = 0;
DROP TABLE IF EXISTS dict_string;
DROP TABLE IF EXISTS dict_ui64;
DROP TABLE IF EXISTS video_views;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE video_views
(
    entityIri String,
    courseId UInt64,
    learnerId UInt64,
    actorId UInt64,
    duration UInt16,
    fullWatched UInt8,
    fullWatchedDate DateTime,
    fullWatchedDuration UInt16,
    fullWatchedTime UInt16,
    fullWatchedViews UInt16,
    `views.viewId` Array(String),
    `views.startedAt` Array(DateTime),
    `views.endedAt` Array(DateTime),
    `views.viewDuration` Array(UInt16),
    `views.watchedPart` Array(Float32),
    `views.fullWatched` Array(UInt8),
    `views.progress` Array(Float32),
    `views.reject` Array(UInt8),
    `views.viewNumber` Array(UInt16),
    `views.repeatingView` Array(UInt8),
    `views.ranges` Array(String),
    version DateTime
)
ENGINE = ReplacingMergeTree(version)
PARTITION BY entityIri
ORDER BY (learnerId, entityIri)
SETTINGS index_granularity = 8192;
CREATE TABLE dict_string (entityIri String) ENGINE = Memory;
CREATE TABLE dict_ui64 (learnerId UInt64) ENGINE = Memory;
