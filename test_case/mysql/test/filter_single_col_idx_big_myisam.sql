
CREATE TABLE t1(
  col1_idx INT DEFAULT NULL,
  col2_idx INT DEFAULT NULL,
  col3 INT DEFAULT NULL,
  col4 INT NOT NULL,
  vc VARCHAR(20),
  vc_ft VARCHAR(20),
  KEY(col1_idx),
  KEY(col2_idx),
  FULLTEXT(vc_ft)
);

CREATE TABLE t2(
  col1_idx INT DEFAULT NULL,
  col2_idx INT DEFAULT NULL,
  col3 INT DEFAULT NULL,
  KEY(col1_idx),
  KEY(col2_idx)
);

insert into t1 values (1,1,1,1,'america', 'america'),(2,2,2,2,'england','england');

let $iteration= 0;
let $i= 2;
{
  eval insert into t1 select col1_idx+$i, col2_idx+$i, col3+$i, col4+$i, vc, vc_ft from t1;
  let $i=$i*2;
  inc $iteration;

insert into t1 select col1_idx, col2_idx, col3, col4, 'america', 'america' from t1;
insert into t1 select col1_idx, col2_idx, col3, col4, 'england america', 'england america' from t1;
insert ignore into t1 select col1_idx, col2_idx, col3, col4, 'germany england america', 'germany england america' from t1;

insert into t1 select col1_idx, col2_idx, col3, col4, 'norway sweden', 'norway sweden' from t1 limit 5;

insert into t2 select col1_idx,col2_idx,col3 from t1;

DROP TABLE t1,t2;
