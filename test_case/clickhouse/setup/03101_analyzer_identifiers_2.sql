SET allow_experimental_analyzer = 1;
CREATE TEMPORARY TABLE test1 (a String, nest Nested(x String, y String));
