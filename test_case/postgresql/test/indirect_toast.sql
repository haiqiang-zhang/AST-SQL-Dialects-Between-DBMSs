SELECT substring(indtoasttest::text, 1, 200) FROM indtoasttest;
VACUUM FREEZE indtoasttest;
CREATE FUNCTION update_using_indirect()
        RETURNS trigger
        LANGUAGE plpgsql AS $$
BEGIN
    NEW := make_tuple_indirect(NEW);
    RETURN NEW;
END$$;
CREATE TRIGGER indtoasttest_update_indirect
        BEFORE INSERT OR UPDATE
        ON indtoasttest
        FOR EACH ROW
        EXECUTE PROCEDURE update_using_indirect();
VACUUM FREEZE indtoasttest;
DROP TABLE indtoasttest;
DROP FUNCTION update_using_indirect();
RESET default_toast_compression;
