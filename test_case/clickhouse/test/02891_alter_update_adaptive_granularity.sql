ALTER TABLE kv
    UPDATE s = 'The Containers library is a generic collection of class templates and algorithms that allow programmers to easily implement common data structures like queues, lists and stacks' WHERE 1
SETTINGS mutations_sync = 2;
SELECT *
FROM kv
WHERE value = 442;
