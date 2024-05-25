set join_use_nulls = 0;
select X.id, Y.id from X right join Y on X.id = Y.id order by X.id, Y.id;
select '-';
select X.id, Y.id from X full join Y on Y.id = X.id order by X.id, Y.id;
select '-';
select X.id, Y.id from X right join Y on X.id = (Y.id - 1) order by X.id, Y.id;
select '-';
select X.id, Y.id from X full join Y on (Y.id - 1) = X.id order by X.id, Y.id;
select '-';
select X.id, Y.id from X right join Y on (X.id + 1) = Y.id order by X.id, Y.id;
select '-';
select X.id, Y.id from X full join Y on Y.id = (X.id + 1) order by X.id, Y.id;
select '-';
select X.id, Y.id from X right join Y on (X.id + 1) = (Y.id + 1) order by X.id, Y.id;
select '-';
select X.id, Y.id from X full join Y on (Y.id + 1) = (X.id + 1) order by X.id, Y.id;
select '----';
set join_use_nulls = 1;
select X.id, Y.id from X right join Y on X.id = Y.id order by X.id, Y.id;
select '-';
select X.id, Y.id from X full join Y on Y.id = X.id order by X.id, Y.id;
select '-';
select X.id, Y.id from X right join Y on X.id = (Y.id - 1) order by X.id, Y.id;
select '-';
select X.id, Y.id from X full join Y on (Y.id - 1) = X.id order by X.id, Y.id;
select '-';
select X.id, Y.id from X right join Y on (X.id + 1) = Y.id order by X.id, Y.id;
select '-';
select X.id, Y.id from X full join Y on Y.id = (X.id + 1) order by X.id, Y.id;
select '-';
select X.id, Y.id from X right join Y on (X.id + 1) = (Y.id + 1) order by X.id, Y.id;
select '-';
select X.id, Y.id from X full join Y on (Y.id + 1) = (X.id + 1) order by X.id, Y.id;
select '-';
drop table X;
drop table Y;
