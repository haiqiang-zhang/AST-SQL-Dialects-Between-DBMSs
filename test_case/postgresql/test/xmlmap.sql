SELECT table_to_xml('testxmlschema.test1', false, false, '');
SELECT table_to_xmlschema('testxmlschema.test1', false, false, '');
SELECT table_to_xml_and_xmlschema('testxmlschema.test1', false, false, '');
SELECT query_to_xml('SELECT * FROM testxmlschema.test1', false, false, '');
SELECT query_to_xmlschema('SELECT * FROM testxmlschema.test1', false, false, '');
SELECT query_to_xml_and_xmlschema('SELECT * FROM testxmlschema.test1', true, true, '');
DECLARE xc CURSOR WITH HOLD FOR SELECT * FROM testxmlschema.test1 ORDER BY 1, 2;
SELECT cursor_to_xml('xc'::refcursor, 5, false, true, '');
SELECT cursor_to_xmlschema('xc'::refcursor, false, true, '');
MOVE BACKWARD ALL IN xc;
SELECT schema_to_xml('testxmlschema', false, true, '');
SELECT schema_to_xmlschema('testxmlschema', false, true, '');
SELECT schema_to_xml_and_xmlschema('testxmlschema', true, true, 'foo');
CREATE DOMAIN testboolxmldomain AS bool;
CREATE DOMAIN testdatexmldomain AS date;
CREATE TABLE testxmlschema.test3
    AS SELECT true c1,
              true::testboolxmldomain c2,
              '2013-02-21'::date c3,
              '2013-02-21'::testdatexmldomain c4;
SELECT xmlforest(c1, c2, c3, c4) FROM testxmlschema.test3;
