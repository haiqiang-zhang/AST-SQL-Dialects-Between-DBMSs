SELECT CONNECTION_ID() INTO @id1;
SELECT variable_value FROM performance_schema.global_status WHERE variable_name='connections' INTO @id3;
SELECT (@id1=@id2);
SELECT (@id2=@id3);
SELECT (@id3=@id4);
