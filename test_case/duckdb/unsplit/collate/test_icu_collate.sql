CREATE TABLE strings(s VARCHAR);
INSERT INTO strings VALUES ('Gabel'), ('GÃÂÃÂÃÂÃÂ¶bel'), ('Goethe'), ('Goldmann'), ('GÃÂÃÂÃÂÃÂ¶the'), ('GÃÂÃÂÃÂÃÂ¶tz');
DELETE FROM strings;
INSERT INTO strings VALUES ('ÃÂÃÂ¨ÃÂÃÂ³ÃÂÃÂÃÂÃÂ¨ÃÂÃÂ²ÃÂÃÂ¸ÃÂÃÂ¤ÃÂÃÂºÃÂÃÂºÃÂÃÂ¥ÃÂÃÂÃÂÃÂ´ÃÂÃÂ©ÃÂÃÂÃÂÃÂ£ÃÂÃÂ§ÃÂÃÂµÃÂÃÂ¡ÃÂÃÂ¥ÃÂÃÂÃÂÃÂ (Lessor side contact)'), ('ÃÂÃÂ¨ÃÂÃÂ³ÃÂÃÂÃÂÃÂ¥ÃÂÃÂÃÂÃÂÃÂÃÂ¤ÃÂÃÂºÃÂÃÂºÃÂÃÂ¥ÃÂÃÂÃÂÃÂ´ÃÂÃÂ©ÃÂÃÂÃÂÃÂ£ÃÂÃÂ§ÃÂÃÂµÃÂÃÂ¡ÃÂÃÂ¥ÃÂÃÂÃÂÃÂ (Lessee side contact)'), ('ÃÂÃÂ¨ÃÂÃÂ§ÃÂÃÂ£ÃÂÃÂ§ÃÂÃÂ´ÃÂÃÂÃÂÃÂ©ÃÂÃÂÃÂÃÂ£ÃÂÃÂ§ÃÂÃÂµÃÂÃÂ¡ÃÂÃÂ¥ÃÂÃÂÃÂÃÂ (Termination contacts)'), ('ÃÂÃÂ¦ÃÂÃÂÃÂÃÂ´ÃÂÃÂ¦ÃÂÃÂÃÂÃÂ°ÃÂÃÂ©ÃÂÃÂÃÂÃÂ£ÃÂÃÂ§ÃÂÃÂµÃÂÃÂ¡ÃÂÃÂ¥ÃÂÃÂÃÂÃÂ (Update contact)');
select icu_sort_key('ÃÂÃÂÃÂÃÂ', 'ro');
SELECT * FROM strings ORDER BY s COLLATE de;
SELECT * FROM strings WHERE 'Goethe' > s COLLATE de ORDER BY 1;
SELECT * FROM strings WHERE 'Goethe' > s ORDER BY 1;
SELECT * FROM strings WHERE 'goethe' > s COLLATE de.NOCASE ORDER BY 1;
SELECT * FROM strings WHERE 'goethe' > s COLLATE NOCASE.de ORDER BY 1;
SELECT * FROM strings ORDER BY s;
SELECT * FROM strings ORDER BY s COLLATE ja.NOCASE;
select chr(2*16*256+1*256+2*16+11) collate da  =chr(12*16+5) collate da;
select icu_sort_key(chr(2*16*256+1*256+2*16+11),'da')=icu_sort_key(chr(12*16+5),'da');
select chr(2*16*256+1*256+2*16+11) collate da > chr(12*16+5) collate da;
select chr(2*16*256+1*256+2*16+11) collate da > chr(12*16+5) collate da;
select count(*) from (select chr(2*16*256+1*256+2*16+11) union select chr(12*16+5)) as t(s) group by s collate da;
select nfc_normalize(chr(2*16*256+1*256+2*16+11))=nfc_normalize(chr(12*16+5));
select count(*) from (select chr(2*16*256+1*256+2*16+11) union select chr(12*16+5)) as t(s) group by s collate nfc;
