SELECT DISTINCT 'Ok.' FROM system.warnings WHERE message ILIKE '%Ordinary%' and message ILIKE '%deprecated%';
DROP DATABASE IF EXISTS 02988_ordinary;
