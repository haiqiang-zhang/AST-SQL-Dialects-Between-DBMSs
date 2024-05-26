CREATE OPERATOR === (
        PROCEDURE = int8eq,
        LEFTARG = bigint,
        RIGHTARG = bigint,
        COMMUTATOR = ===
);
CREATE OPERATOR !== (
        PROCEDURE = int8ne,
        LEFTARG = bigint,
        RIGHTARG = bigint,
        NEGATOR = ===,
        COMMUTATOR = !==
);
DROP OPERATOR !==(bigint, bigint);
