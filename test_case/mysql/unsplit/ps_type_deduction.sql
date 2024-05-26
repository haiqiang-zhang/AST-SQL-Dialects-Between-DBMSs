select json_extract(trace,"$.steps[*].statement_parameters") from information_schema.optimizer_trace;
create table t1(a int);
insert into t1 values(1),(2);
create table t2(a int);
prepare s from "select ?+11.1";
prepare s from "select ?+11";
prepare s from "select ?+?";
prepare s from "select ?+?";
prepare s from "select ?+?";
prepare s from "select ?+?";
prepare s from "select ?+?";
prepare s from "select 1.0+?";
prepare s from "select 1e0+?";
prepare s from "select date(?)";
prepare s from "select 11.1*(?+?)";
prepare s from 'select -(?)';
prepare s from 'select cast(? as time), ?+1';
prepare s from 'select ABS(?)';
prepare s from 'select ?';
prepare s from 'select sum(1) over (order by ?)';
prepare s from 'select sum(1) over (order by 1.1 range ? preceding)';
prepare s from 'select 1 where ? group by ? having ? order by ?';
prepare s from 'select 1 from t1 left join t2 on ?';
prepare s from 'select ?';
prepare s from 'select 1 where ?';
prepare s from 'select cast(? as unsigned)';
prepare s from 'select cast(? as char(10))';
prepare s from 'select cast(? as binary(3))';
prepare s from 'select cast(? as date)';
prepare s from 'select cast(? as time(6))';
prepare s from 'select cast(? as datetime(6))';
prepare s from 'select cast(? as year)';
prepare s from 'select cast(? as float)';
prepare s from 'select cast(? as double)';
prepare s from 'select cast(? as decimal(10))';
prepare s from 'select cast(? as json)';
prepare s from 'select convert(?, decimal(10))';
prepare s from 'select 1 where ? and ?';
prepare s from 'select ?=12, ?=?,
  1 BETWEEN ? AND 4.3, ? BETWEEN 1 AND 4.3, ? BETWEEN ? AND ?,
  ? >= 3, ? >= ?';
prepare s from 'select ifnull(?,?),ifnull(?,cast("2000" as date))';
prepare s from 'select if(?,?,?),if(?,cast("2000" as date),?)';
prepare s from 'select coalesce(?,?,?),coalesce(?,cast("2000" as date),?)';
prepare s from 'select ? in (?,?), ? in (2,?)';
prepare s from 'select ? not in (?,?), ? not in (2,?)';
prepare s from '
select case ? when 3 then 1e0 else 2e0 end,
case 3 when ? then 6 else 12 end,
case ? when ? then 6 else 12 end';
prepare s from '
select case 3 when 3 then ? else 2e0 end,
case 3 when 3 then 1e0 else ? end,
case 3 when 3 then ? else ? end,
case ? when ? then ? else ? end';
prepare s from '
select case ? when ? then ? else ? end';
prepare s from '
select case when 3=2 then ? else 2e0 end,
case when ? then 6 else 12 end,
case when ? then ? else ? end';
prepare s from '
select ? in (select a from t1),
       3 in (select ? from t1)';
prepare s from '
select ? >= ALL(select a from t1),
       ? = ALL (select a from t1),
       ? >= ANY (select a from t1),
       ? NOT IN (select a from t1)';
create table t3 (a mediumblob);
select length(@a),sha2(@a, 0);
prepare s from 'select length(?), sha2(?, 0)';
prepare s from 'insert into t3 values(?)';
select length(a), a=@a from t3;
prepare s from 'update t3 set a=?';
prepare s from 'delete from t3 where a=?';
prepare s from 'insert into t3 select ?';
prepare s from 'insert into t3 select ? union select ?';
prepare s from 'insert into t3 select ? union all select ?';
prepare s from 'create table t4 as select ? as a from t3 limit 1';
prepare s from
 'create table t4 as select cast(? as binary(1000000)) as a from t3
  limit 1';
prepare s from 'select ~ ?';
prepare s from 'select ? IS TRUE';
prepare s from 'select ? IS FALSE';
prepare s from 'select ? IS NOT TRUE';
prepare s from 'select ? IS NOT FALSE';
prepare s from 'select ? IS NULL';
prepare s from 'select ? IS NOT NULL';
prepare s from 'select - ?';
prepare s from 'select ? - ?';
prepare s from 'select ! ?';
prepare s from 'select NOT ?';
prepare s from 'select NOT(?)';
prepare s from 'select ? DIV ?';
prepare s from 'select ? AND ?';
prepare s from 'select ? OR ?';
prepare s from 'select ? XOR ?';
prepare s from 'select ? % ?';
prepare s from 'select ? MOD ?';
prepare s from 'select + ?';
prepare s from 'select ? + ?';
prepare s from 'select - ?';
prepare s from 'select ? - ?';
prepare s from 'select ? * ?';
prepare s from 'select ? / ?';
prepare s from 'select ? = ?';
prepare s from 'select hex(? & ?)';
prepare s from 'select ? & 2';
prepare s from 'select ? | ?';
select '18446744073709551615' | 0;
prepare s from 'select ? ^ ?';
prepare s from 'select ? / ?';
prepare s from 'select ? = ?';
prepare s from 'select ? <=> ?';
prepare s from 'select ? > ?';
prepare s from 'select ? >= ?';
prepare s from 'select ? < ?';
prepare s from 'select ? <= ?';
prepare s from 'select ? <> ?';
prepare s from 'select ? != ?';
prepare s from 'select ? << ?';
prepare s from 'select ? >> ?';
prepare s from 'select ? LIKE ?';
prepare s from 'select ? NOT LIKE ?';
prepare s from 'select ? REGEXP ?';
prepare s from 'select ? RLIKE ?';
prepare s from 'select ? NOT REGEXP ?';
CREATE TABLE articles (
          title VARCHAR(200),
          body TEXT,
          FULLTEXT (title,body)
        );
prepare s from 'select 1 from articles where MATCH (title,body) AGAINST (?)';
DROP TABLE articles;
prepare s from 'select ? SOUNDS LIKE ?';
prepare s from 'select ABS(?)';
prepare s from 'select ACOS(?)';
prepare s from 'select ADDDATE(?,?)';
prepare s from 'select ADDDATE(?, INTERVAL ? MONTH)';
prepare s from 'select ADDDATE(?, INTERVAL ? SECOND)';
prepare s from "SELECT ADDDATE('2008-01-02', interval ? second)";
prepare s from 'select ADDDATE(?, INTERVAL ? DAY_SECOND)';
prepare s from 'select ADDDATE(?, INTERVAL 1 MONTH)';
prepare s from 'select ADDDATE(CAST(? AS DATE), INTERVAL 1 MONTH)';
prepare s from 'select ADDDATE(CAST(? AS DATETIME), INTERVAL 1 SECOND)';
prepare s from 'select ADDTIME(?,?)';
prepare s from "select ADDTIME(?, time'01:01:01')";
prepare s from 'select AES_DECRYPT(?,?)';
prepare s from 'select AES_DECRYPT(?,?,?)';
prepare s from 'select AES_ENCRYPT(?,?)';
prepare s from 'select AES_ENCRYPT(?,?,?)';
prepare s from 'select ANY_VALUE(?)';
prepare s from 'select ASCII(?)';
prepare s from 'select ASIN(?)';
prepare s from 'select ATAN(?)';
prepare s from 'select ATAN(?,?)';
prepare s from 'select ATAN2(?)';
prepare s from 'select ATAN2(?,?)';
prepare s from 'select AVG(?)';
prepare s from 'select BENCHMARK(?,?)';
prepare s from 'select BIN(?)';
prepare s from 'select BIN_TO_UUID(?)';
prepare s from 'select BIN_TO_UUID(?,?)';
prepare s from 'select BINARY(?)';
prepare s from 'select BIT_AND(?)';
prepare s from 'select BIT_COUNT(?)';
prepare s from 'select bit_count(?),bit_count(?)';
prepare s from 'select BIT_LENGTH(?)';
prepare s from 'select BIT_OR(?)';
prepare s from 'select BIT_XOR(?)';
prepare s from 'select CEIL(?)';
prepare s from 'select CEILING(?)';
prepare s from 'select CHAR(?)';
prepare s from 'select CHAR(?,?)';
prepare s from 'select CHAR(?,?,?)';
prepare s from 'select CHAR(?,?,?,?)';
prepare s from 'select CHAR(?,?,?,?,?)';
prepare s from 'select CHAR_LENGTH(?)';
prepare s from 'select CHARACTER_LENGTH(?)';
prepare s from 'select CHARSET(?)';
prepare s from 'select COALESCE(?)';
prepare s from 'select COALESCE(?,?)';
prepare s from 'select COALESCE(?,?,?)';
prepare s from 'select COALESCE(?,?,?,?)';
prepare s from 'select COALESCE(?,?,?,?,?)';
prepare s from 'select COERCIBILITY(?)';
prepare s from 'select COLLATION(?)';
prepare s from 'select COMPRESS(?)';
prepare s from 'select CONCAT(?)';
prepare s from 'select CONCAT(?,?)';
prepare s from 'select CONCAT(?,?,?)';
prepare s from 'select CONCAT(?,?,?,?)';
prepare s from 'select CONCAT(?,?,?,?,?)';
prepare s from 'select CONCAT_WS(?,?)';
prepare s from 'select CONCAT_WS(?,?,?)';
prepare s from 'select CONCAT_WS(?,?,?,?)';
prepare s from 'select CONCAT_WS(?,?,?,?,?)';
prepare s from 'select CONNECTION_ID()';
prepare s from 'select CONV(?,?,?)';
prepare s from 'select CONVERT_TZ(?,?,?)';
prepare s from 'select COS(?)';
prepare s from 'select COT(?)';
prepare s from 'select COUNT(?)';
prepare s from 'select COUNT(DISTINCT ?,?,?,?,?)';
prepare s from 'select CRC32(?)';
prepare s from 'select CURDATE()';
prepare s from 'select CURRENT_DATE()';
prepare s from 'select CURRENT_ROLE()';
prepare s from 'select CURRENT_TIME()';
prepare s from 'select CURRENT_TIMESTAMP()';
prepare s from 'select CURRENT_USER()';
prepare s from 'select CURTIME()';
prepare s from 'select DATABASE()';
prepare s from 'select DATE(?)';
prepare s from 'select DATE_FORMAT(?,?)';
prepare s from 'select DATEDIFF(?,?)';
prepare s from 'select DAY(?)';
prepare s from 'select DAYNAME(?)';
prepare s from 'select DAYOFMONTH(?)';
prepare s from 'select DAYOFWEEK(?)';
prepare s from 'select DAYOFYEAR(?)';
prepare s from 'select DEGREES(?)';
prepare s from 'select ELT(?,?)';
prepare s from 'select ELT(?,?,?)';
prepare s from 'select ELT(?,?,?,?)';
prepare s from 'select ELT(?,?,?,?,?)';
prepare s from 'select EXP(?)';
prepare s from 'select EXPORT_SET(?,?,?)';
prepare s from 'select EXPORT_SET(?,?,?,?)';
prepare s from 'select EXPORT_SET(?,?,?,?,?)';
prepare s from 'select EXTRACT(YEAR FROM ?)';
prepare s from 'select ExtractValue(?,?)';
prepare s from 'select FIELD(?,?)';
prepare s from 'select FIELD(?,?,?)';
prepare s from 'select FIELD(?,?,?,?)';
prepare s from 'select FIELD(?,?,?,?,?)';
prepare s from 'select FIND_IN_SET(?,?)';
prepare s from 'select FIRST_VALUE(?) over () from t1';
prepare s from 'select FLOOR(?)';
prepare s from 'select FORMAT(?,?)';
prepare s from 'select FORMAT(?,?,?)';
prepare s from 'select FOUND_ROWS()';
prepare s from 'select FROM_BASE64(?)';
prepare s from 'select FROM_DAYS(?)';
prepare s from 'select FROM_UNIXTIME(?)';
prepare s from 'select FROM_UNIXTIME(?,?)';
prepare s from 'select GeomCollection(?, ?, ?, ?, ?)';
prepare s from 'select GET_FORMAT(DATE, ?)';
prepare s from 'select GET_LOCK(?,?)';
prepare s from 'select GREATEST(?,?,?,?,?)';
prepare s from 'select GROUP_CONCAT(?)';
prepare s from 'select GROUP_CONCAT(?,?)';
prepare s from 'select GROUP_CONCAT(?,?,?)';
prepare s from 'select GROUP_CONCAT(?,?,?,?)';
prepare s from 'select GROUP_CONCAT(?,?,?,?,?)';
prepare s from 'select GROUP_CONCAT(DISTINCT ?,? ORDER BY ? SEPARATOR ",")';
prepare s from 'select GTID_SUBSET(?,?)';
prepare s from 'select GTID_SUBTRACT(?,?)';
prepare s from 'select HEX(?)';
prepare s from 'select HOUR(?)';
prepare s from 'select ICU_VERSION()';
prepare s from 'select IF(?,?,?)';
prepare s from 'select IFNULL(?,?)';
prepare s from 'select INET_ATON(?)';
prepare s from 'select INET_NTOA(?)';
prepare s from 'select INET6_ATON(?)';
prepare s from 'select INET6_NTOA(?)';
prepare s from 'select INSERT(?,?,?,?)';
prepare s from 'select INSTR(?,?)';
prepare s from 'select INTERVAL(?,?)';
prepare s from 'select INTERVAL(?,?,?)';
prepare s from 'select INTERVAL(?,?,?,?)';
prepare s from 'select INTERVAL(?,?,?,?,?)';
prepare s from 'select IS_FREE_LOCK(?)';
prepare s from 'select IS_IPV4(?)';
prepare s from 'select IS_IPV4_COMPAT(?)';
prepare s from 'select IS_IPV4_MAPPED(?)';
prepare s from 'select IS_IPV6(?)';
prepare s from 'select IS_USED_LOCK(?)';
prepare s from 'select IS_UUID(?)';
prepare s from 'select ISNULL(?)';
prepare s from 'select JSON_ARRAY()';
prepare s from 'select JSON_ARRAY(?)';
prepare s from 'select JSON_ARRAY(?,?)';
prepare s from 'select JSON_ARRAY(?,?,?)';
prepare s from 'select JSON_ARRAY(?,?,?,?)';
prepare s from 'select JSON_ARRAY(?,?,?,?,?)';
prepare s from 'select JSON_ARRAY_APPEND(?,?,?)';
prepare s from 'select JSON_ARRAY_APPEND(?,?,?,?,?)';
prepare s from 'select JSON_ARRAY_INSERT(?,?,?)';
prepare s from 'select JSON_ARRAY_INSERT(?,?,?,?,?)';
prepare s from 'select JSON_ARRAYAGG(?)';
prepare s from 'select JSON_CONTAINS(?,?)';
prepare s from 'select JSON_CONTAINS(?,?,?)';
prepare s from 'select JSON_CONTAINS_PATH(?,?,?)';
prepare s from 'select JSON_CONTAINS_PATH(?,?,?,?)';
prepare s from 'select JSON_CONTAINS_PATH(?,?,?,?,?)';
prepare s from 'select JSON_DEPTH(?)';
prepare s from 'select JSON_EXTRACT(?,?)';
prepare s from 'select JSON_EXTRACT(?,?,?)';
prepare s from 'select JSON_EXTRACT(?,?,?,?)';
prepare s from 'select JSON_EXTRACT(?,?,?,?,?)';
prepare s from 'select JSON_INSERT(?,?,?)';
prepare s from 'select JSON_INSERT(?,?,?,?,?)';
prepare s from 'select JSON_KEYS(?)';
prepare s from 'select JSON_KEYS(?,?)';
prepare s from 'select JSON_LENGTH(?)';
prepare s from 'select JSON_LENGTH(?,?)';
prepare s from 'select JSON_MERGE_PATCH(?,?)';
prepare s from 'select JSON_MERGE_PATCH(?,?,?)';
prepare s from 'select JSON_MERGE_PATCH(?,?,?,?)';
prepare s from 'select JSON_MERGE_PATCH(?,?,?,?,?)';
prepare s from 'select JSON_MERGE_PRESERVE(?,?)';
prepare s from 'select JSON_MERGE_PRESERVE(?,?,?)';
prepare s from 'select JSON_MERGE_PRESERVE(?,?,?,?)';
prepare s from 'select JSON_MERGE_PRESERVE(?,?,?,?,?)';
prepare s from 'select JSON_OBJECT()';
prepare s from 'select JSON_OBJECT(?,?)';
prepare s from 'select JSON_OBJECT(?,?,?,?)';
prepare s from 'select JSON_OBJECTAGG(?,?)';
prepare s from 'select JSON_PRETTY(?)';
prepare s from 'select JSON_QUOTE(?)';
prepare s from 'select JSON_REMOVE(?,?)';
prepare s from 'select JSON_REMOVE(?,?,?)';
prepare s from 'select JSON_REMOVE(?,?,?,?)';
prepare s from 'select JSON_REMOVE(?,?,?,?,?)';
prepare s from 'select JSON_REPLACE(?,?,?)';
prepare s from 'select JSON_REPLACE(?,?,?,?,?)';
prepare s from 'select JSON_SEARCH(?,?,?)';
prepare s from 'select JSON_SEARCH(?,?,?,"x",?)';
prepare s from 'select JSON_SET(?,?,?)';
prepare s from 'select JSON_SET(?,?,?,?,?)';
prepare s from 'select JSON_STORAGE_FREE(?)';
prepare s from 'select JSON_STORAGE_SIZE(?)';
prepare s from
'SELECT *
     FROM
       JSON_TABLE(
         ?,
         "$[*]"
         COLUMNS(
           rowid FOR ORDINALITY,
           ac VARCHAR(100) PATH "$.a" DEFAULT ''111'' ON EMPTY DEFAULT ''999'' ON ERROR,
           aj JSON PATH "$.a" DEFAULT ''{"x": 333}'' ON EMPTY,
           bx INT EXISTS PATH "$.b"
         )
       ) AS tt';
prepare s from 'select JSON_TYPE(?)';
prepare s from 'select JSON_UNQUOTE(?)';
prepare s from 'select JSON_VALID(?)';
prepare s from 'select LAG(?,?,?) over () from t1';
prepare s from 'select LAG(?,?,2.1) over () from t1';
prepare s from 'select LAST_DAY(?)';
prepare s from 'select LAST_INSERT_ID()';
prepare s from 'select LAST_INSERT_ID(?)';
prepare s from 'select LAST_VALUE(?) over () from t1';
prepare s from 'select LCASE(?)';
prepare s from 'select LEAD(?,?,?) over () from t1';
prepare s from 'select LEAD(?,?,2.1) over () from t1';
prepare s from 'select LEAST(?,?,?,?,?)';
prepare s from 'select LEFT(?,?)';
prepare s from 'select LENGTH(?)';
prepare s from 'select LineString(?, ?, ?, ?, ?)';
prepare s from 'select LN(?)';
prepare s from 'select LOAD_FILE(?)';
prepare s from 'select LOCALTIME()';
prepare s from 'select LOCALTIMESTAMP()';
prepare s from 'select LOCATE(?,?)';
prepare s from 'select LOCATE(?,?,?)';
prepare s from 'select LOG(?)';
prepare s from 'select LOG(?,?)';
prepare s from 'select LOG10(?)';
prepare s from 'select LOG2(?)';
prepare s from 'select LOWER(?)';
prepare s from 'select LPAD(?,?,?)';
prepare s from 'select LTRIM(?)';
prepare s from 'select MAKE_SET(?,?)';
prepare s from 'select MAKE_SET(?,?,?)';
prepare s from 'select MAKE_SET(?,?,?,?)';
prepare s from 'select MAKE_SET(?,?,?,?,?)';
prepare s from 'select MAKEDATE(?,?)';
prepare s from 'select MAKETIME(?,?,?)';
prepare s from 'select SOURCE_POS_WAIT(?,?)';
prepare s from 'select SOURCE_POS_WAIT(?,?,?)';
prepare s from 'select SOURCE_POS_WAIT(?,?,?,?)';
prepare s from 'select MAX(?)';
prepare s from 'select MBRContains(?,?)';
prepare s from 'select MBRCoveredBy(?,?)';
prepare s from 'select MBRCovers(?,?)';
prepare s from 'select MBRDisjoint(?,?)';
prepare s from 'select MBREquals(?,?)';
prepare s from 'select MBRIntersects(?,?)';
prepare s from 'select MBROverlaps(?,?)';
prepare s from 'select MBRTouches(?,?)';
prepare s from 'select MBRWithin(?,?)';
prepare s from 'select MD5(?)';
prepare s from 'select MICROSECOND(?)';
prepare s from 'select MID(?,?)';
prepare s from 'select MID(?,?,?)';
prepare s from 'select MIN(?)';
prepare s from 'select MINUTE(?)';
prepare s from 'select MOD(?,?)';
prepare s from 'select MONTH(?)';
prepare s from 'select MONTHNAME(?)';
prepare s from 'select MultiLineString(?, ?, ?, ?, ?)';
prepare s from 'select MultiPoint(?, ?, ?, ?, ?)';
prepare s from 'select MultiPolygon(?, ?, ?, ?, ?)';
prepare s from 'select NOW()';
prepare s from 'select NTH_VALUE(?,?) over () from t1';
prepare s from 'select NTILE(?) over () from t1';
prepare s from 'select NULLIF(?,?)';
prepare s from 'select NULLIF(100,?)';
prepare s from 'select NULLIF(?,100)';
prepare s from 'select 200 + NULLIF(?,?)';
prepare s from 'select 200 + NULLIF("100",?)';
prepare s from 'select 200 + NULLIF(?,"100")';
prepare s from 'select OCT(?)';
prepare s from 'select OCTET_LENGTH(?)';
prepare s from 'select ORD(?)';
prepare s from 'select PERIOD_ADD(?,?)';
prepare s from 'select PERIOD_DIFF(?,?)';
prepare s from 'select PI()';
prepare s from 'select Point(?,?)';
prepare s from 'select Polygon(?, ?, ?, ?, ?)';
prepare s from 'select POW(?,?)';
prepare s from 'select POWER(?,?)';
prepare s from 'select QUARTER(?)';
prepare s from 'select QUOTE(?)';
prepare s from 'select RADIANS(?)';
prepare s from 'select RAND(?)';
prepare s from 'select RANDOM_BYTES(?)';
prepare s from 'select REGEXP_INSTR(?,?)';
prepare s from 'select REGEXP_INSTR(?,?,?)';
prepare s from 'select REGEXP_INSTR(?,?,?,?)';
prepare s from 'select REGEXP_LIKE(?,?)';
prepare s from 'select REGEXP_REPLACE(?,?,?)';
prepare s from 'select REGEXP_REPLACE(?,?,?,?)';
prepare s from 'select REGEXP_REPLACE(?,?,?,?,?)';
prepare s from 'select REGEXP_SUBSTR(?,?)';
prepare s from 'select REGEXP_SUBSTR(?,?,?)';
prepare s from 'select REGEXP_SUBSTR(?,?,?,?)';
prepare s from 'select RELEASE_ALL_LOCKS()';
prepare s from 'select RELEASE_LOCK(?)';
prepare s from 'select REPEAT(?,?)';
prepare s from 'select REPLACE(?,?,?)';
prepare s from 'select REVERSE(?)';
prepare s from 'select RIGHT(?,?)';
prepare s from 'select ROLES_GRAPHML()';
prepare s from 'select ROUND(?)';
prepare s from 'select ROUND(?,?)';
prepare s from 'select ROW_COUNT()';
prepare s from 'select RPAD(?,?,?)';
prepare s from 'select RTRIM(?)';
prepare s from 'select SCHEMA()';
prepare s from 'select SEC_TO_TIME(?)';
prepare s from 'select SECOND(?)';
prepare s from 'select SESSION_USER()';
prepare s from 'select SHA1(?)';
prepare s from 'select SHA2(?,?)';
prepare s from 'select SIGN(?)';
prepare s from 'select SIN(?)';
prepare s from 'select SLEEP(?)';
prepare s from 'select SOUNDEX(?)';
prepare s from 'select SPACE(?)';
prepare s from 'select SQRT(?)';
prepare s from 'select ST_Area(?)';
prepare s from 'select ST_AsBinary(?)';
prepare s from 'select ST_AsBinary(?,?)';
prepare s from 'select ST_AsGeoJSON(?)';
prepare s from 'select ST_AsGeoJSON(?,?)';
prepare s from 'select ST_AsGeoJSON(?,?,?)';
prepare s from 'select ST_AsText(?)';
prepare s from 'select ST_AsText(?,?)';
prepare s from 'select ST_Buffer(?,?)';
prepare s from 'select ST_Buffer(?,?,?)';
prepare s from 'select ST_Buffer(?,?,?,?)';
prepare s from 'select ST_Buffer(?,?,?,?,?)';
prepare s from 'select ST_Buffer_Strategy(?)';
prepare s from 'select ST_Buffer_Strategy(?,?)';
prepare s from 'select ST_Centroid(?)';
prepare s from 'select ST_Contains(?,?)';
prepare s from 'select ST_ConvexHull(?)';
prepare s from 'select ST_Crosses(?,?)';
prepare s from 'select ST_Difference(?,?)';
prepare s from 'select ST_Dimension(?)';
prepare s from 'select ST_Disjoint(?,?)';
prepare s from 'select ST_Distance(?,?)';
prepare s from 'select ST_Distance_Sphere(?,?)';
prepare s from 'select ST_Distance_Sphere(?,?,?)';
prepare s from 'select ST_EndPoint(?)';
prepare s from 'select ST_Envelope(?)';
prepare s from 'select ST_Equals(?,?)';
prepare s from 'select ST_ExteriorRing(?)';
prepare s from 'select ST_GeoHash(?,?)';
prepare s from 'select ST_GeoHash(?,?,?)';
prepare s from 'select ST_GeomCollFromText(?)';
prepare s from 'select ST_GeomCollFromText(?,?)';
prepare s from 'select ST_GeomCollFromText(?,?,?)';
prepare s from 'select ST_GeomCollFromWKB(?)';
prepare s from 'select ST_GeomCollFromWKB(?,?)';
prepare s from 'select ST_GeomCollFromWKB(?,?,?)';
prepare s from 'select ST_GeometryN(?,?)';
prepare s from 'select ST_GeometryType(?)';
prepare s from 'select ST_GeomFromGeoJSON(?)';
prepare s from 'select ST_GeomFromGeoJSON(?,?)';
prepare s from 'select ST_GeomFromGeoJSON(?,?,?)';
prepare s from 'select ST_GeomFromText(?)';
prepare s from 'select ST_GeomFromText(?,?)';
prepare s from 'select ST_GeomFromText(?,?,?)';
prepare s from 'select ST_GeomFromWKB(?)';
prepare s from 'select ST_GeomFromWKB(?,?)';
prepare s from 'select ST_GeomFromWKB(?,?,?)';
prepare s from 'select ST_InteriorRingN(?,?)';
prepare s from 'select ST_Intersection(?,?)';
prepare s from 'select ST_Intersects(?,?)';
prepare s from 'select ST_IsClosed(?)';
prepare s from 'select ST_IsEmpty(?)';
prepare s from 'select ST_IsSimple(?)';
prepare s from 'select ST_IsValid(?)';
prepare s from 'select ST_LatFromGeoHash(?)';
prepare s from 'select ST_Latitude(?)';
prepare s from 'select ST_Latitude(?,?)';
prepare s from 'select ST_Length(?)';
prepare s from 'select ST_LineFromText(?)';
prepare s from 'select ST_LineFromText(?,?)';
prepare s from 'select ST_LineFromText(?,?,?)';
prepare s from 'select ST_LineFromWKB(?)';
prepare s from 'select ST_LineFromWKB(?,?)';
prepare s from 'select ST_LineFromWKB(?,?,?)';
prepare s from 'select ST_LongFromGeoHash(?)';
prepare s from 'select ST_Longitude(?)';
prepare s from 'select ST_Longitude(?,?)';
prepare s from 'select ST_MakeEnvelope(?,?)';
prepare s from 'select ST_MLineFromText(?)';
prepare s from 'select ST_MLineFromText(?,?)';
prepare s from 'select ST_MLineFromText(?,?,?)';
prepare s from 'select ST_MLineFromWKB(?)';
prepare s from 'select ST_MLineFromWKB(?,?)';
prepare s from 'select ST_MLineFromWKB(?,?,?)';
prepare s from 'select ST_MPointFromText(?)';
prepare s from 'select ST_MPointFromText(?,?)';
prepare s from 'select ST_MPointFromText(?,?,?)';
prepare s from 'select ST_MPointFromWKB(?)';
prepare s from 'select ST_MPointFromWKB(?,?)';
prepare s from 'select ST_MPointFromWKB(?,?,?)';
prepare s from 'select ST_MPolyFromText(?)';
prepare s from 'select ST_MPolyFromText(?,?)';
prepare s from 'select ST_MPolyFromText(?,?,?)';
prepare s from 'select ST_MPolyFromWKB(?)';
prepare s from 'select ST_MPolyFromWKB(?,?)';
prepare s from 'select ST_MPolyFromWKB(?,?,?)';
prepare s from 'select ST_NumGeometries(?)';
prepare s from 'select ST_NumInteriorRing(?)';
prepare s from 'select ST_NumPoints(?)';
prepare s from 'select ST_Overlaps(?,?)';
prepare s from 'select ST_PointFromGeoHash(?,?)';
prepare s from 'select ST_PointFromText(?)';
prepare s from 'select ST_PointFromText(?,?)';
prepare s from 'select ST_PointFromText(?,?,?)';
prepare s from 'select ST_PointFromWKB(?)';
prepare s from 'select ST_PointFromWKB(?,?)';
prepare s from 'select ST_PointFromWKB(?,?,?)';
prepare s from 'select ST_PointN(?,?)';
prepare s from 'select ST_PolyFromText(?)';
prepare s from 'select ST_PolyFromText(?,?)';
prepare s from 'select ST_PolyFromText(?,?,?)';
prepare s from 'select ST_PolyFromWKB(?)';
prepare s from 'select ST_PolyFromWKB(?,?)';
prepare s from 'select ST_PolyFromWKB(?,?,?)';
prepare s from 'select ST_Simplify(?,?)';
prepare s from 'select ST_SRID(?)';
prepare s from 'select ST_SRID(?,?)';
prepare s from 'select ST_StartPoint(?)';
prepare s from 'select ST_SwapXY(?)';
prepare s from 'select ST_SymDifference(?,?)';
prepare s from 'select ST_Touches(?,?)';
prepare s from 'select ST_Union(?,?)';
prepare s from 'select ST_Validate(?)';
prepare s from 'select ST_Within(?,?)';
prepare s from 'select ST_X(?)';
prepare s from 'select ST_X(?,?)';
prepare s from 'select ST_Y(?)';
prepare s from 'select ST_Y(?,?)';
prepare s from 'select STATEMENT_DIGEST(?)';
prepare s from 'select STATEMENT_DIGEST_TEXT(?)';
prepare s from 'select STD(?)';
prepare s from 'select STDDEV(?)';
prepare s from 'select STDDEV_POP(?)';
prepare s from 'select STDDEV_SAMP(?)';
prepare s from 'select STR_TO_DATE(?,?)';
prepare s from 'select STRCMP(?,?)';
prepare s from 'select SUBDATE(?,?)';
prepare s from 'select SUBDATE(?, INTERVAL 1 MONTH)';
prepare s from 'select SUBDATE(CAST(? AS DATE), INTERVAL 1 MONTH)';
prepare s from 'select SUBDATE(CAST(? AS DATETIME), INTERVAL 1 SECOND)';
prepare s from 'select SUBSTR(?,?)';
prepare s from 'select SUBSTR(?,?,?)';
prepare s from 'select SUBSTRING(?,?)';
prepare s from 'select SUBSTRING(?,?,?)';
prepare s from 'select SUBSTRING_INDEX(?,?,?)';
prepare s from 'select SUBTIME(?,?)';
prepare s from 'select SUM(?)';
prepare s from 'select SYSDATE()';
prepare s from 'select SYSTEM_USER()';
prepare s from 'select TAN(?)';
prepare s from 'select TIME(?)';
prepare s from 'select TIME_FORMAT(?,?)';
prepare s from 'select TIME_TO_SEC(?)';
prepare s from 'select TIMEDIFF(?,?)';
prepare s from 'select TIMEDIFF(?,"01:02:03")';
prepare s from 'select TIMEDIFF(?,"2001-01-01 01:02:03")';
prepare s from 'select TIMESTAMP(?)';
prepare s from 'select TIMESTAMP(?,?)';
prepare s from 'select TIMESTAMPADD(HOUR,?,?)';
prepare s from 'select TIMESTAMPDIFF(HOUR,?,?)';
prepare s from 'select TO_BASE64(?)';
prepare s from 'select TO_DAYS(?)';
prepare s from 'select TO_SECONDS(?)';
prepare s from 'select TRIM(?)';
prepare s from 'select TRUNCATE(?,?)';
prepare s from 'select UCASE(?)';
prepare s from 'select UNCOMPRESS(?)';
prepare s from 'select UNCOMPRESSED_LENGTH(?)';
prepare s from 'select UNHEX(?)';
prepare s from 'select UNIX_TIMESTAMP()';
prepare s from 'select UNIX_TIMESTAMP(?)';
prepare s from 'select UpdateXML(?,?,?)';
prepare s from 'select UPPER(?)';
prepare s from 'select USER()';
prepare s from 'select UTC_DATE()';
prepare s from 'select UTC_TIME()';
prepare s from 'select UTC_TIMESTAMP()';
prepare s from 'select UUID()';
prepare s from 'select UUID_SHORT()';
prepare s from 'select UUID_TO_BIN(?)';
prepare s from 'select UUID_TO_BIN(?,?)';
prepare s from 'select VALIDATE_PASSWORD_STRENGTH(?)';
DROP TABLE t3;
prepare s from 'select VAR_POP(?)';
prepare s from 'select VAR_SAMP(?)';
prepare s from 'select VARIANCE(?)';
prepare s from 'select VERSION()';
prepare s from 'select WAIT_FOR_EXECUTED_GTID_SET(?)';
prepare s from 'select WAIT_FOR_EXECUTED_GTID_SET(?,?)';
prepare s from 'select WEEK(?)';
prepare s from 'select WEEK(?,?)';
prepare s from 'select WEEKDAY(?)';
prepare s from 'select WEEKOFYEAR(?)';
prepare s from 'select WEIGHT_STRING(?)';
prepare s from 'select YEAR(?)';
prepare s from 'select YEARWEEK(?)';
prepare s from 'select YEARWEEK(?,?)';
DROP TABLE t1,t2;
CREATE TABLE t1
(i1 TINYINT,
 i2 SMALLINT,
 i3 MEDIUMINT,
 i4 INTEGER,
 i8 BIGINT,
 dc1 DECIMAL(6,0),
 dc2 DECIMAL(16,10)
);
INSERT INTO t1 VALUES(1, 1, 1, 1, 1, 1, 1.1111111111);
PREPARE s1 FROM "SELECT i1+? FROM t1";
PREPARE s2 FROM "SELECT i2+? FROM t1";
PREPARE s3 FROM "SELECT i3+? FROM t1";
PREPARE s4 FROM "SELECT i4+? FROM t1";
PREPARE s5 FROM "SELECT i8+? FROM t1";
PREPARE s6 FROM "SELECT dc1+? FROM t1";
PREPARE s7 FROM "SELECT dc2+? FROM t1";
DEALLOCATE PREPARE s1;
DEALLOCATE PREPARE s2;
DEALLOCATE PREPARE s3;
DEALLOCATE PREPARE s4;
DEALLOCATE PREPARE s5;
DEALLOCATE PREPARE s6;
DEALLOCATE PREPARE s7;
DROP TABLE t1;
CREATE TABLE t1
(pk INTEGER,
 i1 TINYINT,
 i2 SMALLINT,
 i3 MEDIUMINT,
 i4 INTEGER,
 i8 BIGINT,
 i1u TINYINT UNSIGNED,
 i2u SMALLINT UNSIGNED,
 i3u MEDIUMINT UNSIGNED,
 i4u INTEGER UNSIGNED,
 i8u BIGINT UNSIGNED,
 dc DECIMAL(16,10),
 f4 FLOAT,
 f8 DOUBLE,
 vc VARCHAR(10),
 fc CHAR(10),
 vb VARBINARY(10),
 fb BINARY(10),
 d DATE,
 t TIME(6),
 dt DATETIME(6),
 ts TIMESTAMP(6)
);
PREPARE si FROM
"INSERT INTO t1 VALUES(1,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
PREPARE su FROM
"UPDATE t1
 SET i1=?, i2=?, i3=?, i4=?, i8=?, i1u=?, i2u=?, i3u=?, i4u=?, i8u=?,
     dc=?, f4=?, f8=?, vc=?, fc=?, vb=?, fb=?, d=?, t=?, dt=?, ts=?
 WHERE pk=1";
PREPARE siu FROM
"INSERT INTO t1 VALUES(1,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
 ON DUPLICATE KEY
 UPDATE i1=?, i2=?, i3=?, i4=?, i8=?, i1u=?, i2u=?, i3u=?, i4u=?, i8u=?,
     dc=?, f4=?, f8=?, vc=?, fc=?, vb=?, fb=?, d=?, t=?, dt=?, ts=?";
DEALLOCATE PREPARE si;
DEALLOCATE PREPARE su;
DEALLOCATE PREPARE siu;
DROP TABLE t1;
PREPARE s1 FROM "SELECT ? + ?";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT 666 + (? + ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT -(?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT 666 + -(?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT GREATEST(?, ?), LEAST(?, ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT 666 + GREATEST(?, ?), 3.14e0 + LEAST(?, ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT COALESCE(?, ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT 666 + COALESCE(?, ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT CASE ? WHEN 1 THEN ? ELSE ? END";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT 666 + CASE ? WHEN 1 THEN ? ELSE ? END";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT IFNULL(?, ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT 666 + IFNULL(?, ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT NULLIF(?, ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT 666 + NULLIF(?, ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT IF(?, ?, ?)";
DEALLOCATE PREPARE s1;
PREPARE s1 FROM "SELECT 666 + IF(?, ?, ?)";
DEALLOCATE PREPARE s1;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (a int);
PREPARE s FROM "DELETE FROM t1 WHERE (?, ?) NOT IN (SELECT 'a', 'b' FROM t2)";
DEALLOCATE PREPARE s;
PREPARE s FROM "SELECT * FROM t1 WHERE (?, ?) NOT IN (SELECT 'a', 'b' FROM t2)";
DEALLOCATE PREPARE s;
DROP TABLE t1, t2;
PREPARE s FROM "SELECT NULL";
PREPARE s FROM "SELECT NULL + ? ";
DEALLOCATE PREPARE s;
CREATE TABLE t1 (
  col1 VARCHAR(100) NOT NULL COLLATE latin1_swedish_ci,
  col2 VARCHAR(200) NOT NULL COLLATE utf8mb4_general_ci
);
PREPARE stmt1 FROM 'SELECT * FROM t1 WHERE col1 LIKE ? OR col2 LIKE ?';
DEALLOCATE PREPARE stmt1;
DROP TABLE t1;
CREATE TABLE t(c VARCHAR(32));
INSERT INTO t VALUES('xyz');
PREPARE ps FROM "SELECT * FROM t WHERE c LIKE ? COLLATE utf8mb4_lt_0900_ai_ci";
DEALLOCATE PREPARE ps;
DROP TABLE t;
PREPARE ps FROM "SELECT format_bytes(?)";
PREPARE ps FROM "SELECT format_pico_time(?)";
PREPARE ps FROM "SELECT ps_thread_id(?)";
