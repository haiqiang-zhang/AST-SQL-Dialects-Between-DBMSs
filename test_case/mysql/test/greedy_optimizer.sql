drop table if exists t1,t2,t3,t4,t5,t6,t7;
create table t1 (
  c11 integer,c12 integer,c13 integer,c14 integer,c15 integer,c16 integer,
  primary key (c11)
);
create table t2 (
  c21 integer,c22 integer,c23 integer,c24 integer,c25 integer,c26 integer
);
create table t3 (
  c31 integer,c32 integer,c33 integer,c34 integer,c35 integer,c36 integer,
  primary key (c31)
);
create table t4 (
  c41 integer,c42 integer,c43 integer,c44 integer,c45 integer,c46 integer
);
create table t5 (
  c51 integer,c52 integer,c53 integer,c54 integer,c55 integer,c56 integer,
  primary key (c51)
);
create table t6 (
  c61 integer,c62 integer,c63 integer,c64 integer,c65 integer,c66 integer
);
create table t7 (
  c71 integer,c72 integer,c73 integer,c74 integer,c75 integer,c76 integer,
  primary key (c71)
);
insert into t1 values (1,2,3,4,5,6);
insert into t1 values (2,2,3,4,5,6);
insert into t1 values (3,2,3,4,5,6);
insert into t2 values (1,2,3,4,5,6);
insert into t2 values (2,2,3,4,5,6);
insert into t2 values (3,2,3,4,5,6);
insert into t2 values (4,2,3,4,5,6);
insert into t2 values (5,2,3,4,5,6);
insert into t2 values (6,2,3,4,5,6);
insert into t3 values (1,2,3,4,5,6);
insert into t3 values (2,2,3,4,5,6);
insert into t3 values (3,2,3,4,5,6);
insert into t3 values (4,2,3,4,5,6);
insert into t3 values (5,2,3,4,5,6);
insert into t3 values (6,2,3,4,5,6);
insert into t3 values (7,2,3,4,5,6);
insert into t3 values (8,2,3,4,5,6);
insert into t3 values (9,2,3,4,5,6);
insert into t4 values (1,2,3,4,5,6);
insert into t4 values (2,2,3,4,5,6);
insert into t4 values (3,2,3,4,5,6);
insert into t4 values (4,2,3,4,5,6);
insert into t4 values (5,2,3,4,5,6);
insert into t4 values (6,2,3,4,5,6);
insert into t4 values (7,2,3,4,5,6);
insert into t4 values (8,2,3,4,5,6);
insert into t4 values (9,2,3,4,5,6);
insert into t4 values (10,2,3,4,5,6);
insert into t4 values (11,2,3,4,5,6);
insert into t4 values (12,2,3,4,5,6);
insert into t5 values (1,2,3,4,5,6);
insert into t5 values (2,2,3,4,5,6);
insert into t5 values (3,2,3,4,5,6);
insert into t5 values (4,2,3,4,5,6);
insert into t5 values (5,2,3,4,5,6);
insert into t5 values (6,2,3,4,5,6);
insert into t5 values (7,2,3,4,5,6);
insert into t5 values (8,2,3,4,5,6);
insert into t5 values (9,2,3,4,5,6);
insert into t5 values (10,2,3,4,5,6);
insert into t5 values (11,2,3,4,5,6);
insert into t5 values (12,2,3,4,5,6);
insert into t5 values (13,2,3,4,5,6);
insert into t5 values (14,2,3,4,5,6);
insert into t5 values (15,2,3,4,5,6);
insert into t6 values (1,2,3,4,5,6);
insert into t6 values (2,2,3,4,5,6);
insert into t6 values (3,2,3,4,5,6);
insert into t6 values (4,2,3,4,5,6);
insert into t6 values (5,2,3,4,5,6);
insert into t6 values (6,2,3,4,5,6);
insert into t6 values (7,2,3,4,5,6);
insert into t6 values (8,2,3,4,5,6);
insert into t6 values (9,2,3,4,5,6);
insert into t6 values (10,2,3,4,5,6);
insert into t6 values (11,2,3,4,5,6);
insert into t6 values (12,2,3,4,5,6);
insert into t6 values (13,2,3,4,5,6);
insert into t6 values (14,2,3,4,5,6);
insert into t6 values (15,2,3,4,5,6);
insert into t6 values (16,2,3,4,5,6);
insert into t6 values (17,2,3,4,5,6);
insert into t6 values (18,2,3,4,5,6);
insert into t7 values (1,2,3,4,5,6);
insert into t7 values (2,2,3,4,5,6);
insert into t7 values (3,2,3,4,5,6);
insert into t7 values (4,2,3,4,5,6);
insert into t7 values (5,2,3,4,5,6);
insert into t7 values (6,2,3,4,5,6);
insert into t7 values (7,2,3,4,5,6);
insert into t7 values (8,2,3,4,5,6);
insert into t7 values (9,2,3,4,5,6);
insert into t7 values (10,2,3,4,5,6);
insert into t7 values (11,2,3,4,5,6);
insert into t7 values (12,2,3,4,5,6);
insert into t7 values (13,2,3,4,5,6);
insert into t7 values (14,2,3,4,5,6);
insert into t7 values (15,2,3,4,5,6);
insert into t7 values (16,2,3,4,5,6);
insert into t7 values (17,2,3,4,5,6);
insert into t7 values (18,2,3,4,5,6);
insert into t7 values (19,2,3,4,5,6);
insert into t7 values (20,2,3,4,5,6);
insert into t7 values (21,2,3,4,5,6);
select @@optimizer_search_depth;
select @@optimizer_prune_level;
select @@optimizer_prune_level;
select @@optimizer_search_depth;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select @@optimizer_search_depth;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select @@optimizer_search_depth;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select @@optimizer_prune_level;
select @@optimizer_search_depth;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select @@optimizer_search_depth;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select @@optimizer_search_depth;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c12 = t2.c21 and t2.c22 = t3.c31 and t3.c32 = t4.c41 and t4.c42 = t5.c51 and t5.c52 = t6.c61 and t6.c62 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71;
select t1.c11 from t1, t2, t3, t4, t5, t6, t7 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
select t1.c11 from t7, t6, t5, t4, t3, t2, t1 where t1.c11 = t2.c21 and t1.c12 = t3.c31 and t1.c13 = t4.c41 and t1.c14 = t5.c51 and t1.c15 = t6.c61 and t1.c16 = t7.c71 and t2.c22 = t3.c32 and t2.c23 = t4.c42 and t2.c24 = t5.c52 and t2.c25 = t6.c62 and t2.c26 = t7.c72 and t3.c33 = t4.c43 and t3.c34 = t5.c53 and t3.c35 = t6.c63 and t3.c36 = t7.c73 and t4.c42 = t5.c54 and t4.c43 = t6.c64 and t4.c44 = t7.c74 and t5.c52 = t6.c65 and t5.c53 = t7.c75 and t6.c62 = t7.c76;
drop table t1,t2,t3,t4,t5,t6,t7;
CREATE TABLE t1 (a int, b int, d int, i int);
CREATE TABLE t2 (b int, c int, j int);
CREATE TABLE t2_1 (j int);
CREATE TABLE t3 (c int, f int);
CREATE TABLE t3_1 (f int);
CREATE TABLE t4 (d int, e int, k int);
CREATE TABLE t4_1 (k int);
CREATE TABLE t5 (g int, d int, h int, l int);
CREATE TABLE t5_1 (l int);
SELECT 1
FROM t1
LEFT JOIN (
  t2 JOIN t3 ON t3.c = t2.c
) ON t2.b = t1.b
LEFT JOIN (
  t4 JOIN t5 ON t5.d = t4.d
) ON t4.d = t1.d;
SELECT 1
FROM t1
LEFT JOIN (
  t2 LEFT JOIN (t3 JOIN t3_1 ON t3.f = t3_1.f) ON t3.c = t2.c
) ON t2.b = t1.b
LEFT JOIN (
  t4 JOIN t5 ON t5.d = t4.d
) ON t4.d = t1.d;
SELECT 1
FROM t1
LEFT JOIN (
 (t2 JOIN t2_1 ON t2.j = t2_1.j) JOIN t3 ON t3.c = t2.c
) ON t2.b = t1.b
LEFT JOIN (
  t4 JOIN t5 ON t5.d = t4.d
) ON t4.d = t1.d;
SELECT 1
FROM t1
LEFT JOIN (
  t2 JOIN t3 ON t3.c = t2.c
) ON t2.b = t1.b
LEFT JOIN (
  (t4 JOIN t4_1 ON t4.k = t4_1.k) LEFT JOIN t5 ON t5.d = t4.d
) ON t4.d = t1.d;
SELECT 1
FROM t1
LEFT JOIN (
  t2 JOIN t3 ON t3.c = t2.c
) ON t2.b = t1.b
LEFT JOIN (
  t4 LEFT JOIN (t5 JOIN t5_1 ON t5.l = t5_1.l) ON t5.d = t4.d
) ON t4.d = t1.d;
DROP TABLE t1,t2,t2_1,t3,t3_1,t4,t4_1,t5,t5_1;
CREATE TABLE t10(
  K INT NOT NULL AUTO_INCREMENT,
  I INT,
  PRIMARY KEY(K)
);
INSERT INTO t10(I) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(0);
CREATE TABLE t100 LIKE t10;
INSERT INTO t100(I)
SELECT X.I FROM t10 AS X,t10 AS Y;
CREATE TABLE t10000 LIKE t10;
INSERT INTO t10000(I)
SELECT X.I FROM t100 AS X, t100 AS Y;
select sum(variable_value) from performance_schema.session_status
 where VARIABLE_NAME like 'Handler_read%';
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t100,t10000
WHERE t100.K=t10.I
  AND t10000.K=t10.I;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t10000,t100
WHERE t100.K=t10.I
  AND t10000.K=t10.I;
SELECT COUNT(*) FROM t10,t100,t10000
WHERE t100.K=t10.I
  AND t10000.K=t10.I;
SELECT COUNT(*) FROM t10,t10000,t100
WHERE t100.K=t10.I
  AND t10000.K=t10.I;
SELECT COUNT(*) FROM t10,t100,t10000
WHERE t100.K=t10.I
  AND t10000.K=t10.K;
SELECT COUNT(*) FROM t10,t10000,t100
WHERE t100.K=t10.I
  AND t10000.K=t10.K;
SELECT COUNT(*) FROM t100,t10,t10000
WHERE t100.K=t10.I
  AND t10000.K=t10.K;
SELECT COUNT(*) FROM t100,t10000,t10
WHERE t100.K=t10.I
  AND t10000.K=t10.K;
SELECT COUNT(*) FROM t10000,t10,t100
WHERE t100.K=t10.I
  AND t10000.K=t10.K;
SELECT COUNT(*) FROM t10000,t100,t10
WHERE t100.K=t10.I
  AND t10000.K=t10.K;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t100,t10000
WHERE t100.K=t10.I
  AND t10000.I=t10.I;
SELECT COUNT(*) FROM t10,t100,t10000
WHERE t100.K=t10.I
  AND t10000.I=t10.I;
SELECT COUNT(*) FROM t10,t10000,t100
WHERE t100.K=t10.I
  AND t10000.I=t10.I;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t10000,t100
WHERE t100.I=t10.I
  AND t10000.K=t10.I;
SELECT COUNT(*) FROM t10,t100,t10000
WHERE t100.I=t10.I
  AND t10000.K=t10.I;
SELECT COUNT(*) FROM t10,t10000,t100
WHERE t100.I=t10.I
  AND t10000.K=t10.I;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t10000,t100
WHERE t100.I=t10.I
  AND t10000.K=t100.I;
SELECT COUNT(*) FROM t10,t100,t10000
WHERE t100.I=t10.I
  AND t10000.K=t100.I;
SELECT COUNT(*) FROM t10,t10000,t100
WHERE t100.I=t10.I
  AND t10000.K=t100.I;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i;
SELECT COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i;
SELECT COUNT(*) FROM t10,t10000 y,t10000 x
WHERE x.k=t10.i;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i
  AND y.i=t10.i;
SELECT COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i
  AND y.i=t10.i;
SELECT COUNT(*) FROM t10,t10000 y,t10000 x
WHERE x.k=t10.i
  AND y.i=t10.i;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i
  AND y.i=x.k;
SELECT COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i
  AND y.i=x.k;
SELECT COUNT(*) FROM t10,t10000 y,t10000 x
WHERE x.k=t10.i
  AND y.i=x.k;
CREATE INDEX IX ON t10(I);
CREATE INDEX IX ON t100(I);
CREATE INDEX IX ON t10000(I);
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t100,t10000
WHERE t100.K=t10.I
  AND t10000.I=t10.I;
SELECT COUNT(*) FROM t10,t100,t10000
WHERE t100.K=t10.I
  AND t10000.I=t10.I;
SELECT COUNT(*) FROM t10,t10000,t100
WHERE t100.K=t10.I
  AND t10000.I=t10.I;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i;
SELECT COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i;
SELECT COUNT(*) FROM t10,t10000 y,t10000 x
WHERE x.k=t10.i;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i
  AND y.i=t10.i;
SELECT COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i
  AND y.i=t10.i;
SELECT COUNT(*) FROM t10,t10000 y,t10000 x
WHERE x.k=t10.i
  AND y.i=t10.i;
SELECT STRAIGHT_JOIN COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i
  AND y.i=x.k;
SELECT COUNT(*) FROM t10,t10000 x,t10000 y
WHERE x.k=t10.i
  AND y.i=x.k;
SELECT COUNT(*) FROM t10,t10000 y,t10000 x
WHERE x.k=t10.i
  AND y.i=x.k;
DROP TABLE t10, t10000;
select @@optimizer_prune_level;
select @@optimizer_search_depth;
select @@optimizer_prune_level;
select @@optimizer_search_depth;
