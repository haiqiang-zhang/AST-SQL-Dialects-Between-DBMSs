
-- no connections when embedded

SELECT CONNECTION_ID() INTO @id1;
SELECT MAX(processlist_id) FROM performance_schema.threads INTO @id2;
SELECT variable_value FROM performance_schema.global_status WHERE variable_name='connections' INTO @id3;
SELECT (@id1=@id2);
SELECT (@id2=@id3);

let $ps= "SHOW PROCESSLIST";
let $cond=1;
let $rowno=1;
{
  let $field_value= query_get_value($ps, User, $rowno);
  if ($field_value == No such row)
  {
    let $cond=0;
  }
  if ($field_value == root)
  {
    let $id= query_get_value($ps, Id, $rowno);
    let $cond=0;
  }
  inc $rowno;
SELECT (@id3=@id4);
