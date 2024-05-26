CREATE TEXT SEARCH DICTIONARY ispell (
                        Template=ispell,
                        DictFile=ispell_sample,
                        AffFile=ispell_sample
);
SELECT ts_lexize('ispell', 'skies');
CREATE TEXT SEARCH DICTIONARY hunspell (
                        Template=ispell,
                        DictFile=ispell_sample,
                        AffFile=hunspell_sample
);
CREATE TEXT SEARCH DICTIONARY hunspell_long (
                        Template=ispell,
                        DictFile=hunspell_sample_long,
                        AffFile=hunspell_sample_long
);
CREATE TEXT SEARCH DICTIONARY hunspell_num (
                        Template=ispell,
                        DictFile=hunspell_sample_num,
                        AffFile=hunspell_sample_num
);
CREATE TEXT SEARCH DICTIONARY hunspell_invalid_1 (
						Template=ispell,
						DictFile=hunspell_sample_long,
						AffFile=ispell_sample
);
CREATE TEXT SEARCH DICTIONARY hunspell_invalid_2 (
						Template=ispell,
						DictFile=hunspell_sample_long,
						AffFile=hunspell_sample_num
);
CREATE TEXT SEARCH DICTIONARY hunspell_invalid_3 (
						Template=ispell,
						DictFile=hunspell_sample_num,
						AffFile=ispell_sample
);
CREATE TEXT SEARCH DICTIONARY synonym (
						Template=synonym,
						Synonyms=synonym_sample
);
SELECT dictinitoption FROM pg_ts_dict WHERE dictname = 'synonym';
ALTER TEXT SEARCH DICTIONARY synonym (CaseSensitive = 1);
SELECT dictinitoption FROM pg_ts_dict WHERE dictname = 'synonym';
ALTER TEXT SEARCH DICTIONARY synonym (CaseSensitive = off);
SELECT dictinitoption FROM pg_ts_dict WHERE dictname = 'synonym';
CREATE TEXT SEARCH DICTIONARY thesaurus (
                        Template=thesaurus,
						DictFile=thesaurus_sample,
						Dictionary=english_stem
);
CREATE TEXT SEARCH CONFIGURATION ispell_tst (
						COPY=english
);
ALTER TEXT SEARCH CONFIGURATION ispell_tst ALTER MAPPING FOR
	word, numword, asciiword, hword, numhword, asciihword, hword_part, hword_numpart, hword_asciipart
	WITH ispell, english_stem;
SELECT to_tsvector('ispell_tst', 'Booking the skies after rebookings for footballklubber from a foot');
SELECT to_tsquery('ispell_tst', 'footballklubber');
CREATE TEXT SEARCH CONFIGURATION hunspell_tst (
						COPY=ispell_tst
);
ALTER TEXT SEARCH CONFIGURATION hunspell_tst ALTER MAPPING
	REPLACE ispell WITH hunspell;
SELECT phraseto_tsquery('hunspell_tst', 'footballyklubber sky');
ALTER TEXT SEARCH CONFIGURATION hunspell_tst ALTER MAPPING
	REPLACE hunspell WITH hunspell_long;
ALTER TEXT SEARCH CONFIGURATION hunspell_tst ALTER MAPPING
	REPLACE hunspell_long WITH hunspell_num;
CREATE TEXT SEARCH CONFIGURATION synonym_tst (
						COPY=english
);
ALTER TEXT SEARCH CONFIGURATION synonym_tst ALTER MAPPING FOR
	asciiword, hword_asciipart, asciihword
	WITH synonym, english_stem;
CREATE TEXT SEARCH CONFIGURATION thesaurus_tst (
						COPY=synonym_tst
);
ALTER TEXT SEARCH CONFIGURATION thesaurus_tst ALTER MAPPING FOR
	asciiword, hword_asciipart, asciihword
	WITH synonym, thesaurus, english_stem;
CREATE TEXT SEARCH CONFIGURATION dummy_tst (COPY=english);
ALTER TEXT SEARCH CONFIGURATION dummy_tst
  ALTER MAPPING FOR word, word WITH ispell;
ALTER TEXT SEARCH CONFIGURATION dummy_tst
  DROP MAPPING FOR word, word;
ALTER TEXT SEARCH CONFIGURATION dummy_tst
  DROP MAPPING IF EXISTS FOR word, word;
ALTER TEXT SEARCH CONFIGURATION dummy_tst
  ADD MAPPING FOR word, word WITH ispell;
DROP TEXT SEARCH CONFIGURATION dummy_tst;
