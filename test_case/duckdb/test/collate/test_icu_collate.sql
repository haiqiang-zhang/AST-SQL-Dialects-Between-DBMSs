SELECT * FROM strings WHERE 'Goethe' > s ORDER BY 1;
select chr(2*16*256+1*256+2*16+11) collate da  =chr(12*16+5) collate da;
select icu_sort_key(chr(2*16*256+1*256+2*16+11),'da')=icu_sort_key(chr(12*16+5),'da');
select chr(2*16*256+1*256+2*16+11) collate da > chr(12*16+5) collate da;
select chr(2*16*256+1*256+2*16+11) collate da > chr(12*16+5) collate da;
select count(*) from (select chr(2*16*256+1*256+2*16+11) union select chr(12*16+5)) as t(s) group by s collate da;
select nfc_normalize(chr(2*16*256+1*256+2*16+11))=nfc_normalize(chr(12*16+5));
select count(*) from (select chr(2*16*256+1*256+2*16+11) union select chr(12*16+5)) as t(s) group by s collate nfc;
