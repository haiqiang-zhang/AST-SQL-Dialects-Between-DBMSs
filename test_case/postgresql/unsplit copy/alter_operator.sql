CREATE FUNCTION alter_op_test_fn(boolean, boolean)
RETURNS boolean AS $$ SELECT NULL::BOOLEAN; $$ LANGUAGE sql IMMUTABLE;
SELECT oprrest, oprjoin FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'boolean'::regtype;
SELECT oprrest, oprjoin FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'boolean'::regtype;
SELECT oprrest, oprjoin FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'boolean'::regtype;
SELECT oprrest, oprjoin FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'boolean'::regtype;
RESET SESSION AUTHORIZATION;
CREATE FUNCTION alter_op_test_fn_bool_real(boolean, real)
RETURNS boolean AS $$ SELECT NULL::BOOLEAN; $$ LANGUAGE sql IMMUTABLE;
CREATE FUNCTION alter_op_test_fn_real_bool(real, boolean)
RETURNS boolean AS $$ SELECT NULL::BOOLEAN; $$ LANGUAGE sql IMMUTABLE;
CREATE OPERATOR === (
    LEFTARG = boolean,
    RIGHTARG = real,
    PROCEDURE = alter_op_test_fn_bool_real
);
CREATE OPERATOR ==== (
    LEFTARG = real,
    RIGHTARG = boolean,
    PROCEDURE = alter_op_test_fn_real_bool
);
CREATE OPERATOR !==== (
    LEFTARG = boolean,
    RIGHTARG = real,
    PROCEDURE = alter_op_test_fn_bool_real
);
SELECT oprcanmerge, oprcanhash
FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'real'::regtype;
SELECT op.oprname AS operator_name, com.oprname AS commutator_name,
  com.oprcode AS commutator_func
  FROM pg_operator op
  INNER JOIN pg_operator com ON (op.oid = com.oprcom AND op.oprcom = com.oid)
  WHERE op.oprname = '==='
  AND op.oprleft = 'boolean'::regtype AND op.oprright = 'real'::regtype;
SELECT op.oprname AS operator_name, neg.oprname AS negator_name,
  neg.oprcode AS negator_func
  FROM pg_operator op
  INNER JOIN pg_operator neg ON (op.oid = neg.oprnegate AND op.oprnegate = neg.oid)
  WHERE op.oprname = '==='
  AND op.oprleft = 'boolean'::regtype AND op.oprright = 'real'::regtype;
SELECT oprcanmerge, oprcanhash,
       pg_describe_object('pg_operator'::regclass, oprcom, 0) AS commutator,
       pg_describe_object('pg_operator'::regclass, oprnegate, 0) AS negator
  FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'real'::regtype;
CREATE OPERATOR @= (
    LEFTARG = real,
    RIGHTARG = boolean,
    PROCEDURE = alter_op_test_fn_real_bool
);
CREATE OPERATOR @!= (
    LEFTARG = boolean,
    RIGHTARG = real,
    PROCEDURE = alter_op_test_fn_bool_real
);
SELECT oprcanmerge, oprcanhash,
       pg_describe_object('pg_operator'::regclass, oprcom, 0) AS commutator,
       pg_describe_object('pg_operator'::regclass, oprnegate, 0) AS negator
  FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'real'::regtype;
DROP OPERATOR === (boolean, real);
DROP OPERATOR ==== (real, boolean);
DROP OPERATOR !==== (boolean, real);
DROP OPERATOR @= (real, boolean);
DROP OPERATOR @!= (boolean, real);
DROP FUNCTION alter_op_test_fn(boolean, boolean);
DROP FUNCTION alter_op_test_fn_bool_real(boolean, real);
DROP FUNCTION alter_op_test_fn_real_bool(real, boolean);
