SELECT /*+ SET_VAR(select_into_disk_sync_delay = 5000) 
           SET_VAR(select_into_disk_sync = ON)
           SET_VAR(select_into_buffer_size = 16384) */
  @@select_into_disk_sync_delay, @@select_into_disk_sync, @@select_into_buffer_size;
DROP TABLE t1, t2;
