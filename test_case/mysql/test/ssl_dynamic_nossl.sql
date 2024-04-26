ALTER INSTANCE RELOAD TLS;

-- Disables TLS by temporarily setting a wrong value, reloading TLS
-- and restoring the wrong value
SET @orig_ssl_ca= @@global.ssl_ca;
SET GLOBAL ssl_ca = 'gizmo';
ALTER INSTANCE RELOAD TLS NO ROLLBACK ON ERROR;
SET GLOBAL ssl_ca = @orig_ssl_ca;
