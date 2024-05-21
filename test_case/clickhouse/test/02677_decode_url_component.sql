SELECT
    encodeURLComponent('ÐºÐ»Ð¸ÐºÑÐ°ÑÑ') AS encoded,
    decodeURLComponent(encoded) = 'ÐºÐ»Ð¸ÐºÑÐ°ÑÑ' AS expected_EQ;
SELECT DISTINCT decodeURLComponent(encodeURLComponent(randomString(100) AS x)) = x FROM numbers(100000);