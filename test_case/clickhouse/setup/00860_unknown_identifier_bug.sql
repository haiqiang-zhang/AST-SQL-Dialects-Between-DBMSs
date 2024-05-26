DROP TABLE IF EXISTS appointment_events;
CREATE TABLE appointment_events
(
    _appointment_id UInt32,
    _id String,
    _status String,
    _set_by_id String,
    _company_id String,
    _client_id String,
    _type String,
    _at String,
    _vacancy_id String,
    _set_at UInt32,
    _job_requisition_id String
) ENGINE = Memory;
INSERT INTO appointment_events (_appointment_id, _set_at, _status) values (1, 1, 'Created'), (2, 2, 'Created');
