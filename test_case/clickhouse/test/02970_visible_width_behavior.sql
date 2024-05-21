SELECT visibleWidth('ClickHouseæ¯ä¸ä¸ªå¾å¥½çæ°æ®åº');
SELECT visibleWidth('ClickHouseæ¯ä¸ä¸ªå¾å¥½çæ°æ®åº') SETTINGS function_visible_width_behavior = 0;
SELECT visibleWidth('ClickHouseæ¯ä¸ä¸ªå¾å¥½çæ°æ®åº') SETTINGS function_visible_width_behavior = 1;
SELECT visibleWidth('ClickHouseæ¯ä¸ä¸ªå¾å¥½çæ°æ®åº') SETTINGS function_visible_width_behavior = 2;
SELECT visibleWidth('ClickHouseæ¯ä¸ä¸ªå¾å¥½çæ°æ®åº') SETTINGS compatibility = '23.12';
SELECT visibleWidth('ClickHouseæ¯ä¸ä¸ªå¾å¥½çæ°æ®åº') SETTINGS compatibility = '24.1';