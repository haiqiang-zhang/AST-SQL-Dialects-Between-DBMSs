PRAGMA enable_verification;
SELECT 251658240::BIGINT * 1080863910568919040::BIGINT;
SELECT 1080863910568919040::BIGINT * 251658240::BIGINT;
SELECT 1080863910568919040::BIGINT * 1080863910568919040::BIGINT;
SELECT -2::BIGINT * 4611686018427387905::BIGINT;
SELECT 10737418240::BIGINT * 1073741823::BIGINT;
SELECT 1073741823::BIGINT * 10737418240::BIGINT;
SELECT (-9223372036854775808)::BIGINT * 2::BIGINT;
SELECT (-9223372036854775808)::BIGINT * -1::BIGINT;
SELECT -1::BIGINT * (-9223372036854775808)::BIGINT;
SELECT -2::BIGINT * (-9223372036854775808)::BIGINT;
SELECT (-9223372036854775807)::BIGINT * 2::BIGINT;
SELECT -2::BIGINT * (-9223372036854775807)::BIGINT;
SELECT 251658240::BIGINT * 251658240::BIGINT;
SELECT -1::BIGINT * 9223372036854775807::BIGINT;
SELECT 8589934592::BIGINT * 1073741823::BIGINT;
SELECT 1073741823::BIGINT * 8589934592::BIGINT;
SELECT 1073741823::BIGINT * 8589934592::BIGINT;
SELECT (-9223372036854775808)::BIGINT * 0::BIGINT;
SELECT (-9223372036854775808)::BIGINT * 1::BIGINT;
SELECT 0::BIGINT * (-9223372036854775808)::BIGINT;
SELECT 1::BIGINT * (-9223372036854775808)::BIGINT;
SELECT (-9223372036854775807)::BIGINT * -1::BIGINT;
SELECT -1::BIGINT * (-9223372036854775807)::BIGINT;
SELECT (-9223372036854775807)::BIGINT * 0::BIGINT;
SELECT (-9223372036854775807)::BIGINT * 1::BIGINT;
SELECT 0::BIGINT * (-9223372036854775807)::BIGINT;
SELECT 1::BIGINT * (-9223372036854775807)::BIGINT;
