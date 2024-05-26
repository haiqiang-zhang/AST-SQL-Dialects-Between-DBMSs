SELECT pg_notify('notify_async1','sample message1');
NOTIFY notify_async2;
LISTEN notify_async2;
UNLISTEN notify_async2;
UNLISTEN *;
SELECT pg_notification_queue_usage();
