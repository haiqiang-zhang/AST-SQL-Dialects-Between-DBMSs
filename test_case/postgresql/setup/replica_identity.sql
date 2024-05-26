CREATE TABLE test_replica_identity (
       id serial primary key,
       keya text not null,
       keyb text not null,
       nonkey text,
       CONSTRAINT test_replica_identity_unique_defer UNIQUE (keya, keyb) DEFERRABLE,
       CONSTRAINT test_replica_identity_unique_nondefer UNIQUE (keya, keyb)
);
CREATE TABLE test_replica_identity_othertable (id serial primary key);
CREATE TABLE test_replica_identity_t3 (id serial constraint pk primary key deferrable);
CREATE INDEX test_replica_identity_keyab ON test_replica_identity (keya, keyb);
CREATE UNIQUE INDEX test_replica_identity_keyab_key ON test_replica_identity (keya, keyb);
CREATE UNIQUE INDEX test_replica_identity_nonkey ON test_replica_identity (keya, nonkey);
CREATE INDEX test_replica_identity_hash ON test_replica_identity USING hash (nonkey);
CREATE UNIQUE INDEX test_replica_identity_expr ON test_replica_identity (keya, keyb, (3));
CREATE UNIQUE INDEX test_replica_identity_partial ON test_replica_identity (keya, keyb) WHERE keyb != '3';
