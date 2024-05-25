CREATE OPERATOR ## (
   leftarg = path,
   rightarg = path,
   function = path_inter,
   commutator = ##
);
CREATE OPERATOR @#@ (
   rightarg = int8,		
   procedure = factorial
);
SELECT @#@ 24;
CREATE OPERATOR !=- (
   rightarg = int8,
   procedure = factorial
);
SELECT !=- 10;
SELECT 2 !=/**/ 1, 2 !=/**/ 2;
SELECT 2 !=
  1;
SELECT true<>-1 BETWEEN 1 AND 1;
SELECT false<>/**/1 BETWEEN 1 AND 1;
SELECT false<=-1 BETWEEN 1 AND 1;
SELECT false>=-1 BETWEEN 1 AND 1;
SELECT 2<=/**/3, 3>=/**/2, 2<>/**/3;
SELECT 3<=/**/2, 2>=/**/3, 2<>/**/2;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
CREATE OR REPLACE FUNCTION fn_op2(boolean, boolean)
RETURNS boolean AS $$
    SELECT NULL::BOOLEAN;
$$ LANGUAGE sql IMMUTABLE;
CREATE OPERATOR === (
    LEFTARG = boolean,
    RIGHTARG = boolean,
    PROCEDURE = fn_op2,
    COMMUTATOR = ===,
    NEGATOR = !==,
    RESTRICT = contsel,
    JOIN = contjoinsel,
    SORT1, SORT2, LTCMP, GTCMP, HASHES, MERGES
);
ROLLBACK;
CREATE OPERATOR #@%# (
   rightarg = int8,
   procedure = factorial,
   invalid_att = int8
);
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
CREATE OPERATOR === (
    leftarg = integer,
    rightarg = integer,
    procedure = int4eq,
    commutator = ===!!!
);
CREATE OPERATOR ===!!! (
    leftarg = integer,
    rightarg = integer,
    procedure = int4ne,
    negator = ===!!!
);
ROLLBACK;
