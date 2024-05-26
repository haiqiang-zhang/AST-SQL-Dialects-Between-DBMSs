SET allow_experimental_analyzer = 1;
CREATE TABLE table (
    column UInt64,
    nest Nested
    (
        key Nested (
            subkey UInt16
        )
    )
) ENGINE = Memory();
