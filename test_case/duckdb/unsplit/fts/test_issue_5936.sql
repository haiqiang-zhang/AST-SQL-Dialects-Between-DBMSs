CREATE TABLE documents(document VARCHAR, url VARCHAR);
INSERT INTO documents VALUES ('hello world', 'https://example.com'), ('foobar', 'https://google.com');
PRAGMA create_fts_index(documents, url, document);
