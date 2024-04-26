SET @global_saved_tmp =  @@global.offline_mode;
SET DEBUG_SYNC='after_lock_offline_mode_acquire SIGNAL lock_offline_mode_acquired WAIT_FOR lock_thd_data_acquired';

SET DEBUG_SYNC='now WAIT_FOR lock_offline_mode_acquired';
SET DEBUG_SYNC='materialize_session_variable_array_THD_locked SIGNAL lock_thd_data_acquired';

SET DEBUG_SYNC='RESET';
SET @@global.offline_mode = @global_saved_tmp;
