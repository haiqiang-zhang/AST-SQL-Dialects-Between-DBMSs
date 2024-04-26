DROP TABLE if exists t1,t2,t3,t4,t5,t6;

SET default_storage_engine=ARCHIVE;
let $MYSQLD_DATADIR= `SELECT @@datadir`;

CREATE TABLE t1 (
  Period smallint(4) unsigned zerofill DEFAULT '0000' NOT NULL,
  Varor_period smallint(4) unsigned DEFAULT '0' NOT NULL
) ENGINE=archive;

INSERT INTO t1 VALUES (9410,9412);
  
select period FROM t1;
select * FROM t1;
select t1.* FROM t1;

--
-- Create test table
--

CREATE TABLE t2 (
  auto int,
  fld1 int(6) unsigned zerofill DEFAULT '000000' NOT NULL,
  companynr tinyint(2) unsigned zerofill DEFAULT '00' NOT NULL,
  fld3 char(30) DEFAULT '' NOT NULL,
  fld4 char(35) DEFAULT '' NOT NULL,
  fld5 char(35) DEFAULT '' NOT NULL,
  fld6 char(4) DEFAULT '' NOT NULL
) ENGINE=archive;

--
-- Populate table
--

--disable_query_log
INSERT INTO t2 VALUES (1,000001,00,'Omaha','teethe','neat','');
INSERT INTO t2 VALUES (2,011401,37,'breaking','dreaded','Steinberg','W');
INSERT INTO t2 VALUES (3,011402,37,'Romans','scholastics','jarring','');
INSERT INTO t2 VALUES (4,011403,37,'intercepted','audiology','tinily','');
INSERT INTO t2 VALUES (5,011501,37,'bewilderingly','wallet','balled','');
INSERT INTO t2 VALUES (6,011701,37,'astound','parters','persist','W');
INSERT INTO t2 VALUES (7,011702,37,'admonishing','eschew','attainments','');
INSERT INTO t2 VALUES (8,011703,37,'sumac','quitter','fanatic','');
INSERT INTO t2 VALUES (9,012001,37,'flanking','neat','measures','FAS');
INSERT INTO t2 VALUES (10,012003,37,'combed','Steinberg','rightfulness','');
INSERT INTO t2 VALUES (11,012004,37,'subjective','jarring','capably','');
INSERT INTO t2 VALUES (12,012005,37,'scatterbrain','tinily','impulsive','');
INSERT INTO t2 VALUES (13,012301,37,'Eulerian','balled','starlet','');
INSERT INTO t2 VALUES (14,012302,36,'dubbed','persist','terminators','');
INSERT INTO t2 VALUES (15,012303,37,'Kane','attainments','untying','');
INSERT INTO t2 VALUES (16,012304,37,'overlay','fanatic','announces','FAS');
INSERT INTO t2 VALUES (17,012305,37,'perturb','measures','featherweight','FAS');
INSERT INTO t2 VALUES (18,012306,37,'goblins','rightfulness','pessimist','FAS');
INSERT INTO t2 VALUES (19,012501,37,'annihilates','capably','daughter','');
INSERT INTO t2 VALUES (20,012602,37,'Wotan','impulsive','decliner','FAS');
INSERT INTO t2 VALUES (21,012603,37,'snatching','starlet','lawgiver','');
INSERT INTO t2 VALUES (22,012604,37,'concludes','terminators','stated','');
INSERT INTO t2 VALUES (23,012605,37,'laterally','untying','readable','');
INSERT INTO t2 VALUES (24,012606,37,'yelped','announces','attrition','');
INSERT INTO t2 VALUES (25,012701,37,'grazing','featherweight','cascade','FAS');
INSERT INTO t2 VALUES (26,012702,37,'Baird','pessimist','motors','FAS');
INSERT INTO t2 VALUES (27,012703,37,'celery','daughter','interrogate','');
INSERT INTO t2 VALUES (28,012704,37,'misunderstander','decliner','pests','W');
INSERT INTO t2 VALUES (29,013601,37,'handgun','lawgiver','stairway','');
INSERT INTO t2 VALUES (30,013602,37,'foldout','stated','dopers','FAS');
INSERT INTO t2 VALUES (31,013603,37,'mystic','readable','testicle','W');
INSERT INTO t2 VALUES (32,013604,37,'succumbed','attrition','Parsifal','W');
INSERT INTO t2 VALUES (33,013605,37,'Nabisco','cascade','leavings','');
INSERT INTO t2 VALUES (34,013606,37,'fingerings','motors','postulation','W');
INSERT INTO t2 VALUES (35,013607,37,'aging','interrogate','squeaking','');
INSERT INTO t2 VALUES (36,013608,37,'afield','pests','contrasted','');
INSERT INTO t2 VALUES (37,013609,37,'ammonium','stairway','leftover','');
INSERT INTO t2 VALUES (38,013610,37,'boat','dopers','whiteners','');
INSERT INTO t2 VALUES (39,013801,37,'intelligibility','testicle','erases','W');
INSERT INTO t2 VALUES (40,013802,37,'Augustine','Parsifal','Punjab','W');
INSERT INTO t2 VALUES (41,013803,37,'teethe','leavings','Merritt','');
INSERT INTO t2 VALUES (42,013804,37,'dreaded','postulation','Quixotism','');
INSERT INTO t2 VALUES (43,013901,37,'scholastics','squeaking','sweetish','FAS');
INSERT INTO t2 VALUES (44,016001,37,'audiology','contrasted','dogging','FAS');
INSERT INTO t2 VALUES (45,016201,37,'wallet','leftover','scornfully','FAS');
INSERT INTO t2 VALUES (46,016202,37,'parters','whiteners','bellow','');
INSERT INTO t2 VALUES (47,016301,37,'eschew','erases','bills','');
INSERT INTO t2 VALUES (48,016302,37,'quitter','Punjab','cupboard','FAS');
INSERT INTO t2 VALUES (49,016303,37,'neat','Merritt','sureties','FAS');
INSERT INTO t2 VALUES (50,016304,37,'Steinberg','Quixotism','puddings','');
INSERT INTO t2 VALUES (51,018001,37,'jarring','sweetish','tapestry','');
INSERT INTO t2 VALUES (52,018002,37,'tinily','dogging','fetters','');
INSERT INTO t2 VALUES (53,018003,37,'balled','scornfully','bivalves','');
INSERT INTO t2 VALUES (54,018004,37,'persist','bellow','incurring','');
INSERT INTO t2 VALUES (55,018005,37,'attainments','bills','Adolph','');
INSERT INTO t2 VALUES (56,018007,37,'fanatic','cupboard','pithed','');
INSERT INTO t2 VALUES (57,018008,37,'measures','sureties','emergency','');
INSERT INTO t2 VALUES (58,018009,37,'rightfulness','puddings','Miles','');
INSERT INTO t2 VALUES (59,018010,37,'capably','tapestry','trimmings','');
INSERT INTO t2 VALUES (60,018012,37,'impulsive','fetters','tragedies','W');
INSERT INTO t2 VALUES (61,018013,37,'starlet','bivalves','skulking','W');
INSERT INTO t2 VALUES (62,018014,37,'terminators','incurring','flint','');
INSERT INTO t2 VALUES (63,018015,37,'untying','Adolph','flopping','W');
INSERT INTO t2 VALUES (64,018016,37,'announces','pithed','relaxing','FAS');
INSERT INTO t2 VALUES (65,018017,37,'featherweight','emergency','offload','FAS');
INSERT INTO t2 VALUES (66,018018,37,'pessimist','Miles','suites','W');
INSERT INTO t2 VALUES (67,018019,37,'daughter','trimmings','lists','FAS');
INSERT INTO t2 VALUES (68,018020,37,'decliner','tragedies','animized','FAS');
INSERT INTO t2 VALUES (69,018021,37,'lawgiver','skulking','multilayer','W');
INSERT INTO t2 VALUES (70,018022,37,'stated','flint','standardizes','FAS');
INSERT INTO t2 VALUES (71,018023,37,'readable','flopping','Judas','');
INSERT INTO t2 VALUES (72,018024,37,'attrition','relaxing','vacuuming','W');
INSERT INTO t2 VALUES (73,018025,37,'cascade','offload','dentally','W');
INSERT INTO t2 VALUES (74,018026,37,'motors','suites','humanness','W');
INSERT INTO t2 VALUES (75,018027,37,'interrogate','lists','inch','W');
INSERT INTO t2 VALUES (76,018028,37,'pests','animized','Weissmuller','W');
INSERT INTO t2 VALUES (77,018029,37,'stairway','multilayer','irresponsibly','W');
INSERT INTO t2 VALUES (78,018030,37,'dopers','standardizes','luckily','FAS');
INSERT INTO t2 VALUES (79,018032,37,'testicle','Judas','culled','W');
INSERT INTO t2 VALUES (80,018033,37,'Parsifal','vacuuming','medical','FAS');
INSERT INTO t2 VALUES (81,018034,37,'leavings','dentally','bloodbath','FAS');
INSERT INTO t2 VALUES (82,018035,37,'postulation','humanness','subschema','W');
INSERT INTO t2 VALUES (83,018036,37,'squeaking','inch','animals','W');
INSERT INTO t2 VALUES (84,018037,37,'contrasted','Weissmuller','Micronesia','');
INSERT INTO t2 VALUES (85,018038,37,'leftover','irresponsibly','repetitions','');
INSERT INTO t2 VALUES (86,018039,37,'whiteners','luckily','Antares','');
INSERT INTO t2 VALUES (87,018040,37,'erases','culled','ventilate','W');
INSERT INTO t2 VALUES (88,018041,37,'Punjab','medical','pityingly','');
INSERT INTO t2 VALUES (89,018042,37,'Merritt','bloodbath','interdependent','');
INSERT INTO t2 VALUES (90,018043,37,'Quixotism','subschema','Graves','FAS');
INSERT INTO t2 VALUES (91,018044,37,'sweetish','animals','neonatal','');
INSERT INTO t2 VALUES (92,018045,37,'dogging','Micronesia','scribbled','FAS');
INSERT INTO t2 VALUES (93,018046,37,'scornfully','repetitions','chafe','W');
INSERT INTO t2 VALUES (94,018048,37,'bellow','Antares','honoring','');
INSERT INTO t2 VALUES (95,018049,37,'bills','ventilate','realtor','');
INSERT INTO t2 VALUES (96,018050,37,'cupboard','pityingly','elite','');
INSERT INTO t2 VALUES (97,018051,37,'sureties','interdependent','funereal','');
INSERT INTO t2 VALUES (98,018052,37,'puddings','Graves','abrogating','');
INSERT INTO t2 VALUES (99,018053,50,'tapestry','neonatal','sorters','');
INSERT INTO t2 VALUES (100,018054,37,'fetters','scribbled','Conley','');
INSERT INTO t2 VALUES (101,018055,37,'bivalves','chafe','lectured','');
INSERT INTO t2 VALUES (102,018056,37,'incurring','honoring','Abraham','');
INSERT INTO t2 VALUES (103,018057,37,'Adolph','realtor','Hawaii','W');
INSERT INTO t2 VALUES (104,018058,37,'pithed','elite','cage','');
INSERT INTO t2 VALUES (105,018059,36,'emergency','funereal','hushes','');
INSERT INTO t2 VALUES (106,018060,37,'Miles','abrogating','Simla','');
INSERT INTO t2 VALUES (107,018061,37,'trimmings','sorters','reporters','');
INSERT INTO t2 VALUES (108,018101,37,'tragedies','Conley','Dutchman','FAS');
INSERT INTO t2 VALUES (109,018102,37,'skulking','lectured','descendants','FAS');
INSERT INTO t2 VALUES (110,018103,37,'flint','Abraham','groupings','FAS');
INSERT INTO t2 VALUES (111,018104,37,'flopping','Hawaii','dissociate','');
INSERT INTO t2 VALUES (112,018201,37,'relaxing','cage','coexist','W');
INSERT INTO t2 VALUES (113,018202,37,'offload','hushes','Beebe','');
INSERT INTO t2 VALUES (114,018402,37,'suites','Simla','Taoism','');
INSERT INTO t2 VALUES (115,018403,37,'lists','reporters','Connally','');
INSERT INTO t2 VALUES (116,018404,37,'animized','Dutchman','fetched','FAS');
INSERT INTO t2 VALUES (117,018405,37,'multilayer','descendants','checkpoints','FAS');
INSERT INTO t2 VALUES (118,018406,37,'standardizes','groupings','rusting','');
INSERT INTO t2 VALUES (119,018409,37,'Judas','dissociate','galling','');
INSERT INTO t2 VALUES (120,018601,37,'vacuuming','coexist','obliterates','');
INSERT INTO t2 VALUES (121,018602,37,'dentally','Beebe','traitor','');
INSERT INTO t2 VALUES (122,018603,37,'humanness','Taoism','resumes','FAS');
INSERT INTO t2 VALUES (123,018801,37,'inch','Connally','analyzable','FAS');
INSERT INTO t2 VALUES (124,018802,37,'Weissmuller','fetched','terminator','FAS');
INSERT INTO t2 VALUES (125,018803,37,'irresponsibly','checkpoints','gritty','FAS');
INSERT INTO t2 VALUES (126,018804,37,'luckily','rusting','firearm','W');
INSERT INTO t2 VALUES (127,018805,37,'culled','galling','minima','');
INSERT INTO t2 VALUES (128,018806,37,'medical','obliterates','Selfridge','');
INSERT INTO t2 VALUES (129,018807,37,'bloodbath','traitor','disable','');
INSERT INTO t2 VALUES (130,018808,37,'subschema','resumes','witchcraft','W');
INSERT INTO t2 VALUES (131,018809,37,'animals','analyzable','betroth','W');
INSERT INTO t2 VALUES (132,018810,37,'Micronesia','terminator','Manhattanize','');
INSERT INTO t2 VALUES (133,018811,37,'repetitions','gritty','imprint','');
INSERT INTO t2 VALUES (134,018812,37,'Antares','firearm','peeked','');
INSERT INTO t2 VALUES (135,019101,37,'ventilate','minima','swelling','');
INSERT INTO t2 VALUES (136,019102,37,'pityingly','Selfridge','interrelationships','W');
INSERT INTO t2 VALUES (137,019103,37,'interdependent','disable','riser','');
INSERT INTO t2 VALUES (138,019201,37,'Graves','witchcraft','Gandhian','W');
INSERT INTO t2 VALUES (139,030501,37,'neonatal','betroth','peacock','A');
INSERT INTO t2 VALUES (140,030502,50,'scribbled','Manhattanize','bee','A');
INSERT INTO t2 VALUES (141,030503,37,'chafe','imprint','kanji','');
INSERT INTO t2 VALUES (142,030504,37,'honoring','peeked','dental','');
INSERT INTO t2 VALUES (143,031901,37,'realtor','swelling','scarf','FAS');
INSERT INTO t2 VALUES (144,036001,37,'elite','interrelationships','chasm','A');
INSERT INTO t2 VALUES (145,036002,37,'funereal','riser','insolence','A');
INSERT INTO t2 VALUES (146,036004,37,'abrogating','Gandhian','syndicate','');
INSERT INTO t2 VALUES (147,036005,37,'sorters','peacock','alike','');
INSERT INTO t2 VALUES (148,038001,37,'Conley','bee','imperial','A');
INSERT INTO t2 VALUES (149,038002,37,'lectured','kanji','convulsion','A');
INSERT INTO t2 VALUES (150,038003,37,'Abraham','dental','railway','A');
INSERT INTO t2 VALUES (151,038004,37,'Hawaii','scarf','validate','A');
INSERT INTO t2 VALUES (152,038005,37,'cage','chasm','normalizes','A');
INSERT INTO t2 VALUES (153,038006,37,'hushes','insolence','comprehensive','');
INSERT INTO t2 VALUES (154,038007,37,'Simla','syndicate','chewing','');
INSERT INTO t2 VALUES (155,038008,37,'reporters','alike','denizen','');
INSERT INTO t2 VALUES (156,038009,37,'Dutchman','imperial','schemer','');
INSERT INTO t2 VALUES (157,038010,37,'descendants','convulsion','chronicle','');
INSERT INTO t2 VALUES (158,038011,37,'groupings','railway','Kline','');
INSERT INTO t2 VALUES (159,038012,37,'dissociate','validate','Anatole','');
INSERT INTO t2 VALUES (160,038013,37,'coexist','normalizes','partridges','');
INSERT INTO t2 VALUES (161,038014,37,'Beebe','comprehensive','brunch','');
INSERT INTO t2 VALUES (162,038015,37,'Taoism','chewing','recruited','');
INSERT INTO t2 VALUES (163,038016,37,'Connally','denizen','dimensions','W');
INSERT INTO t2 VALUES (164,038017,37,'fetched','schemer','Chicana','W');
INSERT INTO t2 VALUES (165,038018,37,'checkpoints','chronicle','announced','');
INSERT INTO t2 VALUES (166,038101,37,'rusting','Kline','praised','FAS');
INSERT INTO t2 VALUES (167,038102,37,'galling','Anatole','employing','');
INSERT INTO t2 VALUES (168,038103,37,'obliterates','partridges','linear','');
INSERT INTO t2 VALUES (169,038104,37,'traitor','brunch','quagmire','');
INSERT INTO t2 VALUES (170,038201,37,'resumes','recruited','western','A');
INSERT INTO t2 VALUES (171,038202,37,'analyzable','dimensions','relishing','');
INSERT INTO t2 VALUES (172,038203,37,'terminator','Chicana','serving','A');
INSERT INTO t2 VALUES (173,038204,37,'gritty','announced','scheduling','');
INSERT INTO t2 VALUES (174,038205,37,'firearm','praised','lore','');
INSERT INTO t2 VALUES (175,038206,37,'minima','employing','eventful','');
INSERT INTO t2 VALUES (176,038208,37,'Selfridge','linear','arteriole','A');
INSERT INTO t2 VALUES (177,042801,37,'disable','quagmire','disentangle','');
INSERT INTO t2 VALUES (178,042802,37,'witchcraft','western','cured','A');
INSERT INTO t2 VALUES (179,046101,37,'betroth','relishing','Fenton','W');
INSERT INTO t2 VALUES (180,048001,37,'Manhattanize','serving','avoidable','A');
INSERT INTO t2 VALUES (181,048002,37,'imprint','scheduling','drains','A');
INSERT INTO t2 VALUES (182,048003,37,'peeked','lore','detectably','FAS');
INSERT INTO t2 VALUES (183,048004,37,'swelling','eventful','husky','');
INSERT INTO t2 VALUES (184,048005,37,'interrelationships','arteriole','impelling','');
INSERT INTO t2 VALUES (185,048006,37,'riser','disentangle','undoes','');
INSERT INTO t2 VALUES (186,048007,37,'Gandhian','cured','evened','');
INSERT INTO t2 VALUES (187,048008,37,'peacock','Fenton','squeezes','');
INSERT INTO t2 VALUES (188,048101,37,'bee','avoidable','destroyer','FAS');
INSERT INTO t2 VALUES (189,048102,37,'kanji','drains','rudeness','');
INSERT INTO t2 VALUES (190,048201,37,'dental','detectably','beaner','FAS');
INSERT INTO t2 VALUES (191,048202,37,'scarf','husky','boorish','');
INSERT INTO t2 VALUES (192,048203,37,'chasm','impelling','Everhart','');
INSERT INTO t2 VALUES (193,048204,37,'insolence','undoes','encompass','A');
INSERT INTO t2 VALUES (194,048205,37,'syndicate','evened','mushrooms','');
INSERT INTO t2 VALUES (195,048301,37,'alike','squeezes','Alison','A');
INSERT INTO t2 VALUES (196,048302,37,'imperial','destroyer','externally','FAS');
INSERT INTO t2 VALUES (197,048303,37,'convulsion','rudeness','pellagra','');
INSERT INTO t2 VALUES (198,048304,37,'railway','beaner','cult','');
INSERT INTO t2 VALUES (199,048305,37,'validate','boorish','creek','A');
INSERT INTO t2 VALUES (200,048401,37,'normalizes','Everhart','Huffman','');
INSERT INTO t2 VALUES (201,048402,37,'comprehensive','encompass','Majorca','FAS');
INSERT INTO t2 VALUES (202,048403,37,'chewing','mushrooms','governing','A');
INSERT INTO t2 VALUES (203,048404,37,'denizen','Alison','gadfly','FAS');
INSERT INTO t2 VALUES (204,048405,37,'schemer','externally','reassigned','FAS');
INSERT INTO t2 VALUES (205,048406,37,'chronicle','pellagra','intentness','W');
INSERT INTO t2 VALUES (206,048407,37,'Kline','cult','craziness','');
INSERT INTO t2 VALUES (207,048408,37,'Anatole','creek','psychic','');
INSERT INTO t2 VALUES (208,048409,37,'partridges','Huffman','squabbled','');
INSERT INTO t2 VALUES (209,048410,37,'brunch','Majorca','burlesque','');
INSERT INTO t2 VALUES (210,048411,37,'recruited','governing','capped','');
INSERT INTO t2 VALUES (211,048412,37,'dimensions','gadfly','extracted','A');
INSERT INTO t2 VALUES (212,048413,37,'Chicana','reassigned','DiMaggio','');
INSERT INTO t2 VALUES (213,048601,37,'announced','intentness','exclamation','FAS');
INSERT INTO t2 VALUES (214,048602,37,'praised','craziness','subdirectory','');
INSERT INTO t2 VALUES (215,048603,37,'employing','psychic','fangs','');
INSERT INTO t2 VALUES (216,048604,37,'linear','squabbled','buyer','A');
INSERT INTO t2 VALUES (217,048801,37,'quagmire','burlesque','pithing','A');
INSERT INTO t2 VALUES (218,050901,37,'western','capped','transistorizing','A');
INSERT INTO t2 VALUES (219,051201,37,'relishing','extracted','nonbiodegradable','');
INSERT INTO t2 VALUES (220,056002,37,'serving','DiMaggio','dislocate','');
INSERT INTO t2 VALUES (221,056003,37,'scheduling','exclamation','monochromatic','FAS');
INSERT INTO t2 VALUES (222,056004,37,'lore','subdirectory','batting','');
INSERT INTO t2 VALUES (223,056102,37,'eventful','fangs','postcondition','A');
INSERT INTO t2 VALUES (224,056203,37,'arteriole','buyer','catalog','FAS');
INSERT INTO t2 VALUES (225,056204,37,'disentangle','pithing','Remus','');
INSERT INTO t2 VALUES (226,058003,37,'cured','transistorizing','devices','A');
INSERT INTO t2 VALUES (227,058004,37,'Fenton','nonbiodegradable','bike','A');
INSERT INTO t2 VALUES (228,058005,37,'avoidable','dislocate','qualify','');
INSERT INTO t2 VALUES (229,058006,37,'drains','monochromatic','detained','');
INSERT INTO t2 VALUES (230,058007,37,'detectably','batting','commended','');
INSERT INTO t2 VALUES (231,058101,37,'husky','postcondition','civilize','');
INSERT INTO t2 VALUES (232,058102,37,'impelling','catalog','Elmhurst','');
INSERT INTO t2 VALUES (233,058103,37,'undoes','Remus','anesthetizing','');
INSERT INTO t2 VALUES (234,058105,37,'evened','devices','deaf','');
INSERT INTO t2 VALUES (235,058111,37,'squeezes','bike','Brigham','');
INSERT INTO t2 VALUES (236,058112,37,'destroyer','qualify','title','');
INSERT INTO t2 VALUES (237,058113,37,'rudeness','detained','coarse','');
INSERT INTO t2 VALUES (238,058114,37,'beaner','commended','combinations','');
INSERT INTO t2 VALUES (239,058115,37,'boorish','civilize','grayness','');
INSERT INTO t2 VALUES (240,058116,37,'Everhart','Elmhurst','innumerable','FAS');
INSERT INTO t2 VALUES (241,058117,37,'encompass','anesthetizing','Caroline','A');
INSERT INTO t2 VALUES (242,058118,37,'mushrooms','deaf','fatty','FAS');
INSERT INTO t2 VALUES (243,058119,37,'Alison','Brigham','eastbound','');
INSERT INTO t2 VALUES (244,058120,37,'externally','title','inexperienced','');
INSERT INTO t2 VALUES (245,058121,37,'pellagra','coarse','hoarder','A');
INSERT INTO t2 VALUES (246,058122,37,'cult','combinations','scotch','W');
INSERT INTO t2 VALUES (247,058123,37,'creek','grayness','passport','A');
INSERT INTO t2 VALUES (248,058124,37,'Huffman','innumerable','strategic','FAS');
INSERT INTO t2 VALUES (249,058125,37,'Majorca','Caroline','gated','');
INSERT INTO t2 VALUES (250,058126,37,'governing','fatty','flog','');
INSERT INTO t2 VALUES (251,058127,37,'gadfly','eastbound','Pipestone','');
INSERT INTO t2 VALUES (252,058128,37,'reassigned','inexperienced','Dar','');
INSERT INTO t2 VALUES (253,058201,37,'intentness','hoarder','Corcoran','');
INSERT INTO t2 VALUES (254,058202,37,'craziness','scotch','flyers','A');
INSERT INTO t2 VALUES (255,058303,37,'psychic','passport','competitions','W');
INSERT INTO t2 VALUES (256,058304,37,'squabbled','strategic','suppliers','FAS');
INSERT INTO t2 VALUES (257,058602,37,'burlesque','gated','skips','');
INSERT INTO t2 VALUES (258,058603,37,'capped','flog','institutes','');
INSERT INTO t2 VALUES (259,058604,37,'extracted','Pipestone','troop','A');
INSERT INTO t2 VALUES (260,058605,37,'DiMaggio','Dar','connective','W');
INSERT INTO t2 VALUES (261,058606,37,'exclamation','Corcoran','denies','');
INSERT INTO t2 VALUES (262,058607,37,'subdirectory','flyers','polka','');
INSERT INTO t2 VALUES (263,060401,36,'fangs','competitions','observations','FAS');
INSERT INTO t2 VALUES (264,061701,36,'buyer','suppliers','askers','');
INSERT INTO t2 VALUES (265,066201,36,'pithing','skips','homeless','FAS');
INSERT INTO t2 VALUES (266,066501,36,'transistorizing','institutes','Anna','');
INSERT INTO t2 VALUES (267,068001,36,'nonbiodegradable','troop','subdirectories','W');
INSERT INTO t2 VALUES (268,068002,36,'dislocate','connective','decaying','FAS');
INSERT INTO t2 VALUES (269,068005,36,'monochromatic','denies','outwitting','W');
INSERT INTO t2 VALUES (270,068006,36,'batting','polka','Harpy','W');
INSERT INTO t2 VALUES (271,068007,36,'postcondition','observations','crazed','');
INSERT INTO t2 VALUES (272,068008,36,'catalog','askers','suffocate','');
INSERT INTO t2 VALUES (273,068009,36,'Remus','homeless','provers','FAS');
INSERT INTO t2 VALUES (274,068010,36,'devices','Anna','technically','');
INSERT INTO t2 VALUES (275,068011,36,'bike','subdirectories','Franklinizations','');
INSERT INTO t2 VALUES (276,068202,36,'qualify','decaying','considered','');
INSERT INTO t2 VALUES (277,068302,36,'detained','outwitting','tinnily','');
INSERT INTO t2 VALUES (278,068303,36,'commended','Harpy','uninterruptedly','');
INSERT INTO t2 VALUES (279,068401,36,'civilize','crazed','whistled','A');
INSERT INTO t2 VALUES (280,068501,36,'Elmhurst','suffocate','automate','');
INSERT INTO t2 VALUES (281,068502,36,'anesthetizing','provers','gutting','W');
INSERT INTO t2 VALUES (282,068503,36,'deaf','technically','surreptitious','');
INSERT INTO t2 VALUES (283,068602,36,'Brigham','Franklinizations','Choctaw','');
INSERT INTO t2 VALUES (284,068603,36,'title','considered','cooks','');
INSERT INTO t2 VALUES (285,068701,36,'coarse','tinnily','millivolt','FAS');
INSERT INTO t2 VALUES (286,068702,36,'combinations','uninterruptedly','counterpoise','');
INSERT INTO t2 VALUES (287,068703,36,'grayness','whistled','Gothicism','');
INSERT INTO t2 VALUES (288,076001,36,'innumerable','automate','feminine','');
INSERT INTO t2 VALUES (289,076002,36,'Caroline','gutting','metaphysically','W');
INSERT INTO t2 VALUES (290,076101,36,'fatty','surreptitious','sanding','A');
INSERT INTO t2 VALUES (291,076102,36,'eastbound','Choctaw','contributorily','');
INSERT INTO t2 VALUES (292,076103,36,'inexperienced','cooks','receivers','FAS');
INSERT INTO t2 VALUES (293,076302,36,'hoarder','millivolt','adjourn','');
INSERT INTO t2 VALUES (294,076303,36,'scotch','counterpoise','straggled','A');
INSERT INTO t2 VALUES (295,076304,36,'passport','Gothicism','druggists','');
INSERT INTO t2 VALUES (296,076305,36,'strategic','feminine','thanking','FAS');
INSERT INTO t2 VALUES (297,076306,36,'gated','metaphysically','ostrich','');
INSERT INTO t2 VALUES (298,076307,36,'flog','sanding','hopelessness','FAS');
INSERT INTO t2 VALUES (299,076402,36,'Pipestone','contributorily','Eurydice','');
INSERT INTO t2 VALUES (300,076501,36,'Dar','receivers','excitation','W');
INSERT INTO t2 VALUES (301,076502,36,'Corcoran','adjourn','presumes','FAS');
INSERT INTO t2 VALUES (302,076701,36,'flyers','straggled','imaginable','FAS');
INSERT INTO t2 VALUES (303,078001,36,'competitions','druggists','concoct','W');
INSERT INTO t2 VALUES (304,078002,36,'suppliers','thanking','peering','W');
INSERT INTO t2 VALUES (305,078003,36,'skips','ostrich','Phelps','FAS');
INSERT INTO t2 VALUES (306,078004,36,'institutes','hopelessness','ferociousness','FAS');
INSERT INTO t2 VALUES (307,078005,36,'troop','Eurydice','sentences','');
INSERT INTO t2 VALUES (308,078006,36,'connective','excitation','unlocks','');
INSERT INTO t2 VALUES (309,078007,36,'denies','presumes','engrossing','W');
INSERT INTO t2 VALUES (310,078008,36,'polka','imaginable','Ruth','');
INSERT INTO t2 VALUES (311,078101,36,'observations','concoct','tying','');
INSERT INTO t2 VALUES (312,078103,36,'askers','peering','exclaimers','');
INSERT INTO t2 VALUES (313,078104,36,'homeless','Phelps','synergy','');
INSERT INTO t2 VALUES (314,078105,36,'Anna','ferociousness','Huey','W');
INSERT INTO t2 VALUES (315,082101,36,'subdirectories','sentences','merging','');
INSERT INTO t2 VALUES (316,083401,36,'decaying','unlocks','judges','A');
INSERT INTO t2 VALUES (317,084001,36,'outwitting','engrossing','Shylock','W');
INSERT INTO t2 VALUES (318,084002,36,'Harpy','Ruth','Miltonism','');
INSERT INTO t2 VALUES (319,086001,36,'crazed','tying','hen','W');
INSERT INTO t2 VALUES (320,086102,36,'suffocate','exclaimers','honeybee','FAS');
INSERT INTO t2 VALUES (321,086201,36,'provers','synergy','towers','');
INSERT INTO t2 VALUES (322,088001,36,'technically','Huey','dilutes','W');
INSERT INTO t2 VALUES (323,088002,36,'Franklinizations','merging','numerals','FAS');
INSERT INTO t2 VALUES (324,088003,36,'considered','judges','democracy','FAS');
INSERT INTO t2 VALUES (325,088004,36,'tinnily','Shylock','Ibero-','');
INSERT INTO t2 VALUES (326,088101,36,'uninterruptedly','Miltonism','invalids','');
INSERT INTO t2 VALUES (327,088102,36,'whistled','hen','behavior','');
INSERT INTO t2 VALUES (328,088103,36,'automate','honeybee','accruing','');
INSERT INTO t2 VALUES (329,088104,36,'gutting','towers','relics','A');
INSERT INTO t2 VALUES (330,088105,36,'surreptitious','dilutes','rackets','');
INSERT INTO t2 VALUES (331,088106,36,'Choctaw','numerals','Fischbein','W');
INSERT INTO t2 VALUES (332,088201,36,'cooks','democracy','phony','W');
INSERT INTO t2 VALUES (333,088203,36,'millivolt','Ibero-','cross','FAS');
INSERT INTO t2 VALUES (334,088204,36,'counterpoise','invalids','cleanup','');
INSERT INTO t2 VALUES (335,088302,37,'Gothicism','behavior','conspirator','');
INSERT INTO t2 VALUES (336,088303,37,'feminine','accruing','label','FAS');
INSERT INTO t2 VALUES (337,088305,37,'metaphysically','relics','university','');
INSERT INTO t2 VALUES (338,088402,37,'sanding','rackets','cleansed','FAS');
INSERT INTO t2 VALUES (339,088501,36,'contributorily','Fischbein','ballgown','');
INSERT INTO t2 VALUES (340,088502,36,'receivers','phony','starlet','');
INSERT INTO t2 VALUES (341,088503,36,'adjourn','cross','aqueous','');
INSERT INTO t2 VALUES (342,098001,58,'straggled','cleanup','portrayal','A');
INSERT INTO t2 VALUES (343,098002,58,'druggists','conspirator','despising','W');
INSERT INTO t2 VALUES (344,098003,58,'thanking','label','distort','W');
INSERT INTO t2 VALUES (345,098004,58,'ostrich','university','palmed','');
INSERT INTO t2 VALUES (346,098005,58,'hopelessness','cleansed','faced','');
INSERT INTO t2 VALUES (347,098006,58,'Eurydice','ballgown','silverware','');
INSERT INTO t2 VALUES (348,141903,29,'excitation','starlet','assessor','');
INSERT INTO t2 VALUES (349,098008,58,'presumes','aqueous','spiders','');
INSERT INTO t2 VALUES (350,098009,58,'imaginable','portrayal','artificially','');
INSERT INTO t2 VALUES (351,098010,58,'concoct','despising','reminiscence','');
INSERT INTO t2 VALUES (352,098011,58,'peering','distort','Mexican','');
INSERT INTO t2 VALUES (353,098012,58,'Phelps','palmed','obnoxious','');
INSERT INTO t2 VALUES (354,098013,58,'ferociousness','faced','fragile','');
INSERT INTO t2 VALUES (355,098014,58,'sentences','silverware','apprehensible','');
INSERT INTO t2 VALUES (356,098015,58,'unlocks','assessor','births','');
INSERT INTO t2 VALUES (357,098016,58,'engrossing','spiders','garages','');
INSERT INTO t2 VALUES (358,098017,58,'Ruth','artificially','panty','');
INSERT INTO t2 VALUES (359,098018,58,'tying','reminiscence','anteater','');
INSERT INTO t2 VALUES (360,098019,58,'exclaimers','Mexican','displacement','A');
INSERT INTO t2 VALUES (361,098020,58,'synergy','obnoxious','drovers','A');
INSERT INTO t2 VALUES (362,098021,58,'Huey','fragile','patenting','A');
INSERT INTO t2 VALUES (363,098022,58,'merging','apprehensible','far','A');
INSERT INTO t2 VALUES (364,098023,58,'judges','births','shrieks','');
INSERT INTO t2 VALUES (365,098024,58,'Shylock','garages','aligning','W');
INSERT INTO t2 VALUES (366,098025,37,'Miltonism','panty','pragmatism','');
INSERT INTO t2 VALUES (367,106001,36,'hen','anteater','fevers','W');
INSERT INTO t2 VALUES (368,108001,36,'honeybee','displacement','reexamines','A');
INSERT INTO t2 VALUES (369,108002,36,'towers','drovers','occupancies','');
INSERT INTO t2 VALUES (370,108003,36,'dilutes','patenting','sweats','FAS');
INSERT INTO t2 VALUES (371,108004,36,'numerals','far','modulators','');
INSERT INTO t2 VALUES (372,108005,36,'democracy','shrieks','demand','W');
INSERT INTO t2 VALUES (373,108007,36,'Ibero-','aligning','Madeira','');
INSERT INTO t2 VALUES (374,108008,36,'invalids','pragmatism','Viennese','W');
INSERT INTO t2 VALUES (375,108009,36,'behavior','fevers','chillier','W');
INSERT INTO t2 VALUES (376,108010,36,'accruing','reexamines','wildcats','FAS');
INSERT INTO t2 VALUES (377,108011,36,'relics','occupancies','gentle','');
INSERT INTO t2 VALUES (378,108012,36,'rackets','sweats','Angles','W');
INSERT INTO t2 VALUES (379,108101,36,'Fischbein','modulators','accuracies','');
INSERT INTO t2 VALUES (380,108102,36,'phony','demand','toggle','');
INSERT INTO t2 VALUES (381,108103,36,'cross','Madeira','Mendelssohn','W');
INSERT INTO t2 VALUES (382,108111,50,'cleanup','Viennese','behaviorally','');
INSERT INTO t2 VALUES (383,108105,36,'conspirator','chillier','Rochford','');
INSERT INTO t2 VALUES (384,108106,36,'label','wildcats','mirror','W');
INSERT INTO t2 VALUES (385,108107,36,'university','gentle','Modula','');
INSERT INTO t2 VALUES (386,108108,50,'cleansed','Angles','clobbering','');
INSERT INTO t2 VALUES (387,108109,36,'ballgown','accuracies','chronography','');
INSERT INTO t2 VALUES (388,108110,36,'starlet','toggle','Eskimoizeds','');
INSERT INTO t2 VALUES (389,108201,36,'aqueous','Mendelssohn','British','W');
INSERT INTO t2 VALUES (390,108202,36,'portrayal','behaviorally','pitfalls','');
INSERT INTO t2 VALUES (391,108203,36,'despising','Rochford','verify','W');
INSERT INTO t2 VALUES (392,108204,36,'distort','mirror','scatter','FAS');
INSERT INTO t2 VALUES (393,108205,36,'palmed','Modula','Aztecan','');
INSERT INTO t2 VALUES (394,108301,36,'faced','clobbering','acuity','W');
INSERT INTO t2 VALUES (395,108302,36,'silverware','chronography','sinking','W');
INSERT INTO t2 VALUES (396,112101,36,'assessor','Eskimoizeds','beasts','FAS');
INSERT INTO t2 VALUES (397,112102,36,'spiders','British','Witt','W');
INSERT INTO t2 VALUES (398,113701,36,'artificially','pitfalls','physicists','FAS');
INSERT INTO t2 VALUES (399,116001,36,'reminiscence','verify','folksong','A');
INSERT INTO t2 VALUES (400,116201,36,'Mexican','scatter','strokes','FAS');
INSERT INTO t2 VALUES (401,116301,36,'obnoxious','Aztecan','crowder','');
INSERT INTO t2 VALUES (402,116302,36,'fragile','acuity','merry','');
INSERT INTO t2 VALUES (403,116601,36,'apprehensible','sinking','cadenced','');
INSERT INTO t2 VALUES (404,116602,36,'births','beasts','alimony','A');
INSERT INTO t2 VALUES (405,116603,36,'garages','Witt','principled','A');
INSERT INTO t2 VALUES (406,116701,36,'panty','physicists','golfing','');
INSERT INTO t2 VALUES (407,116702,36,'anteater','folksong','undiscovered','');
INSERT INTO t2 VALUES (408,118001,36,'displacement','strokes','irritates','');
INSERT INTO t2 VALUES (409,118002,36,'drovers','crowder','patriots','A');
INSERT INTO t2 VALUES (410,118003,36,'patenting','merry','rooms','FAS');
INSERT INTO t2 VALUES (411,118004,36,'far','cadenced','towering','W');
INSERT INTO t2 VALUES (412,118005,36,'shrieks','alimony','displease','');
INSERT INTO t2 VALUES (413,118006,36,'aligning','principled','photosensitive','');
INSERT INTO t2 VALUES (414,118007,36,'pragmatism','golfing','inking','');
INSERT INTO t2 VALUES (415,118008,36,'fevers','undiscovered','gainers','');
INSERT INTO t2 VALUES (416,118101,36,'reexamines','irritates','leaning','A');
INSERT INTO t2 VALUES (417,118102,36,'occupancies','patriots','hydrant','A');
INSERT INTO t2 VALUES (418,118103,36,'sweats','rooms','preserve','');
INSERT INTO t2 VALUES (419,118202,36,'modulators','towering','blinded','A');
INSERT INTO t2 VALUES (420,118203,36,'demand','displease','interactions','A');
INSERT INTO t2 VALUES (421,118204,36,'Madeira','photosensitive','Barry','');
INSERT INTO t2 VALUES (422,118302,36,'Viennese','inking','whiteness','A');
INSERT INTO t2 VALUES (423,118304,36,'chillier','gainers','pastimes','W');
INSERT INTO t2 VALUES (424,118305,36,'wildcats','leaning','Edenization','');
INSERT INTO t2 VALUES (425,118306,36,'gentle','hydrant','Muscat','');
INSERT INTO t2 VALUES (426,118307,36,'Angles','preserve','assassinated','');
INSERT INTO t2 VALUES (427,123101,36,'accuracies','blinded','labeled','');
INSERT INTO t2 VALUES (428,123102,36,'toggle','interactions','glacial','A');
INSERT INTO t2 VALUES (429,123301,36,'Mendelssohn','Barry','implied','W');
INSERT INTO t2 VALUES (430,126001,36,'behaviorally','whiteness','bibliographies','W');
INSERT INTO t2 VALUES (431,126002,36,'Rochford','pastimes','Buchanan','');
INSERT INTO t2 VALUES (432,126003,36,'mirror','Edenization','forgivably','FAS');
INSERT INTO t2 VALUES (433,126101,36,'Modula','Muscat','innuendo','A');
INSERT INTO t2 VALUES (434,126301,36,'clobbering','assassinated','den','FAS');
INSERT INTO t2 VALUES (435,126302,36,'chronography','labeled','submarines','W');
INSERT INTO t2 VALUES (436,126402,36,'Eskimoizeds','glacial','mouthful','A');
INSERT INTO t2 VALUES (437,126601,36,'British','implied','expiring','');
INSERT INTO t2 VALUES (438,126602,36,'pitfalls','bibliographies','unfulfilled','FAS');
INSERT INTO t2 VALUES (439,126702,36,'verify','Buchanan','precession','');
INSERT INTO t2 VALUES (440,128001,36,'scatter','forgivably','nullified','');
INSERT INTO t2 VALUES (441,128002,36,'Aztecan','innuendo','affects','');
INSERT INTO t2 VALUES (442,128003,36,'acuity','den','Cynthia','');
INSERT INTO t2 VALUES (443,128004,36,'sinking','submarines','Chablis','A');
INSERT INTO t2 VALUES (444,128005,36,'beasts','mouthful','betterments','FAS');
INSERT INTO t2 VALUES (445,128007,36,'Witt','expiring','advertising','');
INSERT INTO t2 VALUES (446,128008,36,'physicists','unfulfilled','rubies','A');
INSERT INTO t2 VALUES (447,128009,36,'folksong','precession','southwest','FAS');
INSERT INTO t2 VALUES (448,128010,36,'strokes','nullified','superstitious','A');
INSERT INTO t2 VALUES (449,128011,36,'crowder','affects','tabernacle','W');
INSERT INTO t2 VALUES (450,128012,36,'merry','Cynthia','silk','A');
INSERT INTO t2 VALUES (451,128013,36,'cadenced','Chablis','handsomest','A');
INSERT INTO t2 VALUES (452,128014,36,'alimony','betterments','Persian','A');
INSERT INTO t2 VALUES (453,128015,36,'principled','advertising','analog','W');
INSERT INTO t2 VALUES (454,128016,36,'golfing','rubies','complex','W');
INSERT INTO t2 VALUES (455,128017,36,'undiscovered','southwest','Taoist','');
INSERT INTO t2 VALUES (456,128018,36,'irritates','superstitious','suspend','');
INSERT INTO t2 VALUES (457,128019,36,'patriots','tabernacle','relegated','');
INSERT INTO t2 VALUES (458,128020,36,'rooms','silk','awesome','W');
INSERT INTO t2 VALUES (459,128021,36,'towering','handsomest','Bruxelles','');
INSERT INTO t2 VALUES (460,128022,36,'displease','Persian','imprecisely','A');
INSERT INTO t2 VALUES (461,128023,36,'photosensitive','analog','televise','');
INSERT INTO t2 VALUES (462,128101,36,'inking','complex','braking','');
INSERT INTO t2 VALUES (463,128102,36,'gainers','Taoist','true','FAS');
INSERT INTO t2 VALUES (464,128103,36,'leaning','suspend','disappointing','FAS');
INSERT INTO t2 VALUES (465,128104,36,'hydrant','relegated','navally','W');
INSERT INTO t2 VALUES (466,128106,36,'preserve','awesome','circus','');
INSERT INTO t2 VALUES (467,128107,36,'blinded','Bruxelles','beetles','');
INSERT INTO t2 VALUES (468,128108,36,'interactions','imprecisely','trumps','');
INSERT INTO t2 VALUES (469,128202,36,'Barry','televise','fourscore','W');
INSERT INTO t2 VALUES (470,128203,36,'whiteness','braking','Blackfoots','');
INSERT INTO t2 VALUES (471,128301,36,'pastimes','true','Grady','');
INSERT INTO t2 VALUES (472,128302,36,'Edenization','disappointing','quiets','FAS');
INSERT INTO t2 VALUES (473,128303,36,'Muscat','navally','floundered','FAS');
INSERT INTO t2 VALUES (474,128304,36,'assassinated','circus','profundity','W');
INSERT INTO t2 VALUES (475,128305,36,'labeled','beetles','Garrisonian','W');
INSERT INTO t2 VALUES (476,128307,36,'glacial','trumps','Strauss','');
INSERT INTO t2 VALUES (477,128401,36,'implied','fourscore','cemented','FAS');
INSERT INTO t2 VALUES (478,128502,36,'bibliographies','Blackfoots','contrition','A');
INSERT INTO t2 VALUES (479,128503,36,'Buchanan','Grady','mutations','');
INSERT INTO t2 VALUES (480,128504,36,'forgivably','quiets','exhibits','W');
INSERT INTO t2 VALUES (481,128505,36,'innuendo','floundered','tits','');
INSERT INTO t2 VALUES (482,128601,36,'den','profundity','mate','A');
INSERT INTO t2 VALUES (483,128603,36,'submarines','Garrisonian','arches','');
INSERT INTO t2 VALUES (484,128604,36,'mouthful','Strauss','Moll','');
INSERT INTO t2 VALUES (485,128702,36,'expiring','cemented','ropers','');
INSERT INTO t2 VALUES (486,128703,36,'unfulfilled','contrition','bombast','');
INSERT INTO t2 VALUES (487,128704,36,'precession','mutations','difficultly','A');
INSERT INTO t2 VALUES (488,138001,36,'nullified','exhibits','adsorption','');
INSERT INTO t2 VALUES (489,138002,36,'affects','tits','definiteness','FAS');
INSERT INTO t2 VALUES (490,138003,36,'Cynthia','mate','cultivation','A');
INSERT INTO t2 VALUES (491,138004,36,'Chablis','arches','heals','A');
INSERT INTO t2 VALUES (492,138005,36,'betterments','Moll','Heusen','W');
INSERT INTO t2 VALUES (493,138006,36,'advertising','ropers','target','FAS');
INSERT INTO t2 VALUES (494,138007,36,'rubies','bombast','cited','A');
INSERT INTO t2 VALUES (495,138008,36,'southwest','difficultly','congresswoman','W');
INSERT INTO t2 VALUES (496,138009,36,'superstitious','adsorption','Katherine','');
INSERT INTO t2 VALUES (497,138102,36,'tabernacle','definiteness','titter','A');
INSERT INTO t2 VALUES (498,138103,36,'silk','cultivation','aspire','A');
INSERT INTO t2 VALUES (499,138104,36,'handsomest','heals','Mardis','');
INSERT INTO t2 VALUES (500,138105,36,'Persian','Heusen','Nadia','W');
INSERT INTO t2 VALUES (501,138201,36,'analog','target','estimating','FAS');
INSERT INTO t2 VALUES (502,138302,36,'complex','cited','stuck','A');
INSERT INTO t2 VALUES (503,138303,36,'Taoist','congresswoman','fifteenth','A');
INSERT INTO t2 VALUES (504,138304,36,'suspend','Katherine','Colombo','');
INSERT INTO t2 VALUES (505,138401,29,'relegated','titter','survey','A');
INSERT INTO t2 VALUES (506,140102,29,'awesome','aspire','staffing','');
INSERT INTO t2 VALUES (507,140103,29,'Bruxelles','Mardis','obtain','');
INSERT INTO t2 VALUES (508,140104,29,'imprecisely','Nadia','loaded','');
INSERT INTO t2 VALUES (509,140105,29,'televise','estimating','slaughtered','');
INSERT INTO t2 VALUES (510,140201,29,'braking','stuck','lights','A');
INSERT INTO t2 VALUES (511,140701,29,'true','fifteenth','circumference','');
INSERT INTO t2 VALUES (512,141501,29,'disappointing','Colombo','dull','A');
INSERT INTO t2 VALUES (513,141502,29,'navally','survey','weekly','A');
INSERT INTO t2 VALUES (514,141901,29,'circus','staffing','wetness','');
INSERT INTO t2 VALUES (515,141902,29,'beetles','obtain','visualized','');
INSERT INTO t2 VALUES (516,142101,29,'trumps','loaded','Tannenbaum','');
INSERT INTO t2 VALUES (517,142102,29,'fourscore','slaughtered','moribund','');
INSERT INTO t2 VALUES (518,142103,29,'Blackfoots','lights','demultiplex','');
INSERT INTO t2 VALUES (519,142701,29,'Grady','circumference','lockings','');
INSERT INTO t2 VALUES (520,143001,29,'quiets','dull','thugs','FAS');
INSERT INTO t2 VALUES (521,143501,29,'floundered','weekly','unnerves','');
INSERT INTO t2 VALUES (522,143502,29,'profundity','wetness','abut','');
INSERT INTO t2 VALUES (523,148001,29,'Garrisonian','visualized','Chippewa','A');
INSERT INTO t2 VALUES (524,148002,29,'Strauss','Tannenbaum','stratifications','A');
INSERT INTO t2 VALUES (525,148003,29,'cemented','moribund','signaled','');
INSERT INTO t2 VALUES (526,148004,29,'contrition','demultiplex','Italianizes','A');
INSERT INTO t2 VALUES (527,148005,29,'mutations','lockings','algorithmic','A');
INSERT INTO t2 VALUES (528,148006,29,'exhibits','thugs','paranoid','FAS');
INSERT INTO t2 VALUES (529,148007,29,'tits','unnerves','camping','A');
INSERT INTO t2 VALUES (530,148009,29,'mate','abut','signifying','A');
INSERT INTO t2 VALUES (531,148010,29,'arches','Chippewa','Patrice','W');
INSERT INTO t2 VALUES (532,148011,29,'Moll','stratifications','search','A');
INSERT INTO t2 VALUES (533,148012,29,'ropers','signaled','Angeles','A');
INSERT INTO t2 VALUES (534,148013,29,'bombast','Italianizes','semblance','');
INSERT INTO t2 VALUES (535,148023,36,'difficultly','algorithmic','taxed','');
INSERT INTO t2 VALUES (536,148015,29,'adsorption','paranoid','Beatrice','');
INSERT INTO t2 VALUES (537,148016,29,'definiteness','camping','retrace','');
INSERT INTO t2 VALUES (538,148017,29,'cultivation','signifying','lockout','');
INSERT INTO t2 VALUES (539,148018,29,'heals','Patrice','grammatic','');
INSERT INTO t2 VALUES (540,148019,29,'Heusen','search','helmsman','');
INSERT INTO t2 VALUES (541,148020,29,'target','Angeles','uniform','W');
INSERT INTO t2 VALUES (542,148021,29,'cited','semblance','hamming','');
INSERT INTO t2 VALUES (543,148022,29,'congresswoman','taxed','disobedience','');
INSERT INTO t2 VALUES (544,148101,29,'Katherine','Beatrice','captivated','A');
INSERT INTO t2 VALUES (545,148102,29,'titter','retrace','transferals','A');
INSERT INTO t2 VALUES (546,148201,29,'aspire','lockout','cartographer','A');
INSERT INTO t2 VALUES (547,148401,29,'Mardis','grammatic','aims','FAS');
INSERT INTO t2 VALUES (548,148402,29,'Nadia','helmsman','Pakistani','');
INSERT INTO t2 VALUES (549,148501,29,'estimating','uniform','burglarized','FAS');
INSERT INTO t2 VALUES (550,148502,29,'stuck','hamming','saucepans','A');
INSERT INTO t2 VALUES (551,148503,29,'fifteenth','disobedience','lacerating','A');
INSERT INTO t2 VALUES (552,148504,29,'Colombo','captivated','corny','');
INSERT INTO t2 VALUES (553,148601,29,'survey','transferals','megabytes','FAS');
INSERT INTO t2 VALUES (554,148602,29,'staffing','cartographer','chancellor','');
INSERT INTO t2 VALUES (555,150701,29,'obtain','aims','bulk','A');
INSERT INTO t2 VALUES (556,152101,29,'loaded','Pakistani','commits','A');
INSERT INTO t2 VALUES (557,152102,29,'slaughtered','burglarized','meson','W');
INSERT INTO t2 VALUES (558,155202,36,'lights','saucepans','deputies','');
INSERT INTO t2 VALUES (559,155203,29,'circumference','lacerating','northeaster','A');
INSERT INTO t2 VALUES (560,155204,29,'dull','corny','dipole','');
INSERT INTO t2 VALUES (561,155205,29,'weekly','megabytes','machining','0');
INSERT INTO t2 VALUES (562,156001,29,'wetness','chancellor','therefore','');
INSERT INTO t2 VALUES (563,156002,29,'visualized','bulk','Telefunken','');
INSERT INTO t2 VALUES (564,156102,29,'Tannenbaum','commits','salvaging','');
INSERT INTO t2 VALUES (565,156301,29,'moribund','meson','Corinthianizes','A');
INSERT INTO t2 VALUES (566,156302,29,'demultiplex','deputies','restlessly','A');
INSERT INTO t2 VALUES (567,156303,29,'lockings','northeaster','bromides','');
INSERT INTO t2 VALUES (568,156304,29,'thugs','dipole','generalized','A');
INSERT INTO t2 VALUES (569,156305,29,'unnerves','machining','mishaps','');
INSERT INTO t2 VALUES (570,156306,29,'abut','therefore','quelling','');
INSERT INTO t2 VALUES (571,156501,29,'Chippewa','Telefunken','spiritual','A');
INSERT INTO t2 VALUES (572,158001,29,'stratifications','salvaging','beguiles','FAS');
INSERT INTO t2 VALUES (573,158002,29,'signaled','Corinthianizes','Trobriand','FAS');
INSERT INTO t2 VALUES (574,158101,29,'Italianizes','restlessly','fleeing','A');
INSERT INTO t2 VALUES (575,158102,29,'algorithmic','bromides','Armour','A');
INSERT INTO t2 VALUES (576,158103,29,'paranoid','generalized','chin','A');
INSERT INTO t2 VALUES (577,158201,29,'camping','mishaps','provers','A');
INSERT INTO t2 VALUES (578,158202,29,'signifying','quelling','aeronautic','A');
INSERT INTO t2 VALUES (579,158203,29,'Patrice','spiritual','voltage','W');
INSERT INTO t2 VALUES (580,158204,29,'search','beguiles','sash','');
INSERT INTO t2 VALUES (581,158301,29,'Angeles','Trobriand','anaerobic','A');
INSERT INTO t2 VALUES (582,158302,29,'semblance','fleeing','simultaneous','A');
INSERT INTO t2 VALUES (583,158303,29,'taxed','Armour','accumulating','A');
INSERT INTO t2 VALUES (584,158304,29,'Beatrice','chin','Medusan','A');
INSERT INTO t2 VALUES (585,158305,29,'retrace','provers','shouted','A');
INSERT INTO t2 VALUES (586,158306,29,'lockout','aeronautic','freakish','');
INSERT INTO t2 VALUES (587,158501,29,'grammatic','voltage','index','FAS');
INSERT INTO t2 VALUES (588,160301,29,'helmsman','sash','commercially','');
INSERT INTO t2 VALUES (589,166101,50,'uniform','anaerobic','mistiness','A');
INSERT INTO t2 VALUES (590,166102,50,'hamming','simultaneous','endpoint','');
INSERT INTO t2 VALUES (591,168001,29,'disobedience','accumulating','straight','A');
INSERT INTO t2 VALUES (592,168002,29,'captivated','Medusan','flurried','');
INSERT INTO t2 VALUES (593,168003,29,'transferals','shouted','denotative','A');
INSERT INTO t2 VALUES (594,168101,29,'cartographer','freakish','coming','FAS');
INSERT INTO t2 VALUES (595,168102,29,'aims','index','commencements','FAS');
INSERT INTO t2 VALUES (596,168103,29,'Pakistani','commercially','gentleman','');
INSERT INTO t2 VALUES (597,168104,29,'burglarized','mistiness','gifted','');
INSERT INTO t2 VALUES (598,168202,29,'saucepans','endpoint','Shanghais','');
INSERT INTO t2 VALUES (599,168301,29,'lacerating','straight','sportswriting','A');
INSERT INTO t2 VALUES (600,168502,29,'corny','flurried','sloping','A');
INSERT INTO t2 VALUES (601,168503,29,'megabytes','denotative','navies','');
INSERT INTO t2 VALUES (602,168601,29,'chancellor','coming','leaflet','A');
INSERT INTO t2 VALUES (603,173001,40,'bulk','commencements','shooter','');
INSERT INTO t2 VALUES (604,173701,40,'commits','gentleman','Joplin','FAS');
INSERT INTO t2 VALUES (605,173702,40,'meson','gifted','babies','');
INSERT INTO t2 VALUES (606,176001,40,'deputies','Shanghais','subdivision','FAS');
INSERT INTO t2 VALUES (607,176101,40,'northeaster','sportswriting','burstiness','W');
INSERT INTO t2 VALUES (608,176201,40,'dipole','sloping','belted','FAS');
INSERT INTO t2 VALUES (609,176401,40,'machining','navies','assails','FAS');
INSERT INTO t2 VALUES (610,176501,40,'therefore','leaflet','admiring','W');
INSERT INTO t2 VALUES (611,176601,40,'Telefunken','shooter','swaying','0');
INSERT INTO t2 VALUES (612,176602,40,'salvaging','Joplin','Goldstine','FAS');
INSERT INTO t2 VALUES (613,176603,40,'Corinthianizes','babies','fitting','');
INSERT INTO t2 VALUES (614,178001,40,'restlessly','subdivision','Norwalk','W');
INSERT INTO t2 VALUES (615,178002,40,'bromides','burstiness','weakening','W');
INSERT INTO t2 VALUES (616,178003,40,'generalized','belted','analogy','FAS');
INSERT INTO t2 VALUES (617,178004,40,'mishaps','assails','deludes','');
INSERT INTO t2 VALUES (618,178005,40,'quelling','admiring','cokes','');
INSERT INTO t2 VALUES (619,178006,40,'spiritual','swaying','Clayton','');
INSERT INTO t2 VALUES (620,178007,40,'beguiles','Goldstine','exhausts','');
INSERT INTO t2 VALUES (621,178008,40,'Trobriand','fitting','causality','');
INSERT INTO t2 VALUES (622,178101,40,'fleeing','Norwalk','sating','FAS');
INSERT INTO t2 VALUES (623,178102,40,'Armour','weakening','icon','');
INSERT INTO t2 VALUES (624,178103,40,'chin','analogy','throttles','');
INSERT INTO t2 VALUES (625,178201,40,'provers','deludes','communicants','FAS');
INSERT INTO t2 VALUES (626,178202,40,'aeronautic','cokes','dehydrate','FAS');
INSERT INTO t2 VALUES (627,178301,40,'voltage','Clayton','priceless','FAS');
INSERT INTO t2 VALUES (628,178302,40,'sash','exhausts','publicly','');
INSERT INTO t2 VALUES (629,178401,40,'anaerobic','causality','incidentals','FAS');
INSERT INTO t2 VALUES (630,178402,40,'simultaneous','sating','commonplace','');
INSERT INTO t2 VALUES (631,178403,40,'accumulating','icon','mumbles','');
INSERT INTO t2 VALUES (632,178404,40,'Medusan','throttles','furthermore','W');
INSERT INTO t2 VALUES (633,178501,40,'shouted','communicants','cautioned','W');
INSERT INTO t2 VALUES (634,186002,37,'freakish','dehydrate','parametrized','A');
INSERT INTO t2 VALUES (635,186102,37,'index','priceless','registration','A');
INSERT INTO t2 VALUES (636,186201,40,'commercially','publicly','sadly','FAS');
INSERT INTO t2 VALUES (637,186202,40,'mistiness','incidentals','positioning','');
INSERT INTO t2 VALUES (638,186203,40,'endpoint','commonplace','babysitting','');
INSERT INTO t2 VALUES (639,186302,37,'straight','mumbles','eternal','A');
INSERT INTO t2 VALUES (640,188007,37,'flurried','furthermore','hoarder','');
INSERT INTO t2 VALUES (641,188008,37,'denotative','cautioned','congregates','');
INSERT INTO t2 VALUES (642,188009,37,'coming','parametrized','rains','');
INSERT INTO t2 VALUES (643,188010,37,'commencements','registration','workers','W');
INSERT INTO t2 VALUES (644,188011,37,'gentleman','sadly','sags','A');
INSERT INTO t2 VALUES (645,188012,37,'gifted','positioning','unplug','W');
INSERT INTO t2 VALUES (646,188013,37,'Shanghais','babysitting','garage','A');
INSERT INTO t2 VALUES (647,188014,37,'sportswriting','eternal','boulder','A');
INSERT INTO t2 VALUES (648,188015,37,'sloping','hoarder','hollowly','A');
INSERT INTO t2 VALUES (649,188016,37,'navies','congregates','specifics','');
INSERT INTO t2 VALUES (650,188017,37,'leaflet','rains','Teresa','');
INSERT INTO t2 VALUES (651,188102,37,'shooter','workers','Winsett','');
INSERT INTO t2 VALUES (652,188103,37,'Joplin','sags','convenient','A');
INSERT INTO t2 VALUES (653,188202,37,'babies','unplug','buckboards','FAS');
INSERT INTO t2 VALUES (654,188301,40,'subdivision','garage','amenities','');
INSERT INTO t2 VALUES (655,188302,40,'burstiness','boulder','resplendent','FAS');
INSERT INTO t2 VALUES (656,188303,40,'belted','hollowly','priding','FAS');
INSERT INTO t2 VALUES (657,188401,37,'assails','specifics','configurations','');
INSERT INTO t2 VALUES (658,188402,37,'admiring','Teresa','untidiness','A');
INSERT INTO t2 VALUES (659,188503,37,'swaying','Winsett','Brice','W');
INSERT INTO t2 VALUES (660,188504,37,'Goldstine','convenient','sews','FAS');
INSERT INTO t2 VALUES (661,188505,37,'fitting','buckboards','participated','');
INSERT INTO t2 VALUES (662,190701,37,'Norwalk','amenities','Simon','FAS');
INSERT INTO t2 VALUES (663,190703,50,'weakening','resplendent','certificates','');
INSERT INTO t2 VALUES (664,191701,37,'analogy','priding','Fitzpatrick','');
INSERT INTO t2 VALUES (665,191702,37,'deludes','configurations','Evanston','A');
INSERT INTO t2 VALUES (666,191703,37,'cokes','untidiness','misted','');
INSERT INTO t2 VALUES (667,196001,37,'Clayton','Brice','textures','A');
INSERT INTO t2 VALUES (668,196002,37,'exhausts','sews','save','');
INSERT INTO t2 VALUES (669,196003,37,'causality','participated','count','');
INSERT INTO t2 VALUES (670,196101,37,'sating','Simon','rightful','A');
INSERT INTO t2 VALUES (671,196103,37,'icon','certificates','chaperone','');
INSERT INTO t2 VALUES (672,196104,37,'throttles','Fitzpatrick','Lizzy','A');
INSERT INTO t2 VALUES (673,196201,37,'communicants','Evanston','clenched','A');
INSERT INTO t2 VALUES (674,196202,37,'dehydrate','misted','effortlessly','');
INSERT INTO t2 VALUES (675,196203,37,'priceless','textures','accessed','');
INSERT INTO t2 VALUES (676,198001,37,'publicly','save','beaters','A');
INSERT INTO t2 VALUES (677,198003,37,'incidentals','count','Hornblower','FAS');
INSERT INTO t2 VALUES (678,198004,37,'commonplace','rightful','vests','A');
INSERT INTO t2 VALUES (679,198005,37,'mumbles','chaperone','indulgences','FAS');
INSERT INTO t2 VALUES (680,198006,37,'furthermore','Lizzy','infallibly','A');
INSERT INTO t2 VALUES (681,198007,37,'cautioned','clenched','unwilling','FAS');
INSERT INTO t2 VALUES (682,198008,37,'parametrized','effortlessly','excrete','FAS');
INSERT INTO t2 VALUES (683,198009,37,'registration','accessed','spools','A');
INSERT INTO t2 VALUES (684,198010,37,'sadly','beaters','crunches','FAS');
INSERT INTO t2 VALUES (685,198011,37,'positioning','Hornblower','overestimating','FAS');
INSERT INTO t2 VALUES (686,198012,37,'babysitting','vests','ineffective','');
INSERT INTO t2 VALUES (687,198013,37,'eternal','indulgences','humiliation','A');
INSERT INTO t2 VALUES (688,198014,37,'hoarder','infallibly','sophomore','');
INSERT INTO t2 VALUES (689,198015,37,'congregates','unwilling','star','');
INSERT INTO t2 VALUES (690,198017,37,'rains','excrete','rifles','');
INSERT INTO t2 VALUES (691,198018,37,'workers','spools','dialysis','');
INSERT INTO t2 VALUES (692,198019,37,'sags','crunches','arriving','');
INSERT INTO t2 VALUES (693,198020,37,'unplug','overestimating','indulge','');
INSERT INTO t2 VALUES (694,198021,37,'garage','ineffective','clockers','');
INSERT INTO t2 VALUES (695,198022,37,'boulder','humiliation','languages','');
INSERT INTO t2 VALUES (696,198023,50,'hollowly','sophomore','Antarctica','A');
INSERT INTO t2 VALUES (697,198024,37,'specifics','star','percentage','');
INSERT INTO t2 VALUES (698,198101,37,'Teresa','rifles','ceiling','A');
INSERT INTO t2 VALUES (699,198103,37,'Winsett','dialysis','specification','');
INSERT INTO t2 VALUES (700,198105,37,'convenient','arriving','regimented','A');
INSERT INTO t2 VALUES (701,198106,37,'buckboards','indulge','ciphers','');
INSERT INTO t2 VALUES (702,198201,37,'amenities','clockers','pictures','A');
INSERT INTO t2 VALUES (703,198204,37,'resplendent','languages','serpents','A');
INSERT INTO t2 VALUES (704,198301,53,'priding','Antarctica','allot','A');
INSERT INTO t2 VALUES (705,198302,53,'configurations','percentage','realized','A');
INSERT INTO t2 VALUES (706,198303,53,'untidiness','ceiling','mayoral','A');
INSERT INTO t2 VALUES (707,198304,53,'Brice','specification','opaquely','A');
INSERT INTO t2 VALUES (708,198401,37,'sews','regimented','hostess','FAS');
INSERT INTO t2 VALUES (709,198402,37,'participated','ciphers','fiftieth','');
INSERT INTO t2 VALUES (710,198403,37,'Simon','pictures','incorrectly','');
INSERT INTO t2 VALUES (711,202101,37,'certificates','serpents','decomposition','FAS');
INSERT INTO t2 VALUES (712,202301,37,'Fitzpatrick','allot','stranglings','');
INSERT INTO t2 VALUES (713,202302,37,'Evanston','realized','mixture','FAS');
INSERT INTO t2 VALUES (714,202303,37,'misted','mayoral','electroencephalography','FAS');
INSERT INTO t2 VALUES (715,202304,37,'textures','opaquely','similarities','FAS');
INSERT INTO t2 VALUES (716,202305,37,'save','hostess','charges','W');
INSERT INTO t2 VALUES (717,202601,37,'count','fiftieth','freest','FAS');
INSERT INTO t2 VALUES (718,202602,37,'rightful','incorrectly','Greenberg','FAS');
INSERT INTO t2 VALUES (719,202605,37,'chaperone','decomposition','tinting','');
INSERT INTO t2 VALUES (720,202606,37,'Lizzy','stranglings','expelled','W');
INSERT INTO t2 VALUES (721,202607,37,'clenched','mixture','warm','');
INSERT INTO t2 VALUES (722,202901,37,'effortlessly','electroencephalography','smoothed','');
INSERT INTO t2 VALUES (723,202902,37,'accessed','similarities','deductions','FAS');
INSERT INTO t2 VALUES (724,202903,37,'beaters','charges','Romano','W');
INSERT INTO t2 VALUES (725,202904,37,'Hornblower','freest','bitterroot','');
INSERT INTO t2 VALUES (726,202907,37,'vests','Greenberg','corset','');
INSERT INTO t2 VALUES (727,202908,37,'indulgences','tinting','securing','');
INSERT INTO t2 VALUES (728,203101,37,'infallibly','expelled','environing','FAS');
INSERT INTO t2 VALUES (729,203103,37,'unwilling','warm','cute','');
INSERT INTO t2 VALUES (730,203104,37,'excrete','smoothed','Crays','');
INSERT INTO t2 VALUES (731,203105,37,'spools','deductions','heiress','FAS');
INSERT INTO t2 VALUES (732,203401,37,'crunches','Romano','inform','FAS');
INSERT INTO t2 VALUES (733,203402,37,'overestimating','bitterroot','avenge','');
INSERT INTO t2 VALUES (734,203404,37,'ineffective','corset','universals','');
INSERT INTO t2 VALUES (735,203901,37,'humiliation','securing','Kinsey','W');
INSERT INTO t2 VALUES (736,203902,37,'sophomore','environing','ravines','FAS');
INSERT INTO t2 VALUES (737,203903,37,'star','cute','bestseller','');
INSERT INTO t2 VALUES (738,203906,37,'rifles','Crays','equilibrium','');
INSERT INTO t2 VALUES (739,203907,37,'dialysis','heiress','extents','0');
INSERT INTO t2 VALUES (740,203908,37,'arriving','inform','relatively','');
INSERT INTO t2 VALUES (741,203909,37,'indulge','avenge','pressure','FAS');
INSERT INTO t2 VALUES (742,206101,37,'clockers','universals','critiques','FAS');
INSERT INTO t2 VALUES (743,206201,37,'languages','Kinsey','befouled','');
INSERT INTO t2 VALUES (744,206202,37,'Antarctica','ravines','rightfully','FAS');
INSERT INTO t2 VALUES (745,206203,37,'percentage','bestseller','mechanizing','FAS');
INSERT INTO t2 VALUES (746,206206,37,'ceiling','equilibrium','Latinizes','');
INSERT INTO t2 VALUES (747,206207,37,'specification','extents','timesharing','');
INSERT INTO t2 VALUES (748,206208,37,'regimented','relatively','Aden','');
INSERT INTO t2 VALUES (749,208001,37,'ciphers','pressure','embassies','');
INSERT INTO t2 VALUES (750,208002,37,'pictures','critiques','males','FAS');
INSERT INTO t2 VALUES (751,208003,37,'serpents','befouled','shapelessly','FAS');
INSERT INTO t2 VALUES (752,208004,37,'allot','rightfully','genres','FAS');
INSERT INTO t2 VALUES (753,208008,37,'realized','mechanizing','mastering','');
INSERT INTO t2 VALUES (754,208009,37,'mayoral','Latinizes','Newtonian','');
INSERT INTO t2 VALUES (755,208010,37,'opaquely','timesharing','finishers','FAS');
INSERT INTO t2 VALUES (756,208011,37,'hostess','Aden','abates','');
INSERT INTO t2 VALUES (757,208101,37,'fiftieth','embassies','teem','');
INSERT INTO t2 VALUES (758,208102,37,'incorrectly','males','kiting','FAS');
INSERT INTO t2 VALUES (759,208103,37,'decomposition','shapelessly','stodgy','FAS');
INSERT INTO t2 VALUES (760,208104,37,'stranglings','genres','scalps','FAS');
INSERT INTO t2 VALUES (761,208105,37,'mixture','mastering','feed','FAS');
INSERT INTO t2 VALUES (762,208110,37,'electroencephalography','Newtonian','guitars','');
INSERT INTO t2 VALUES (763,208111,37,'similarities','finishers','airships','');
INSERT INTO t2 VALUES (764,208112,37,'charges','abates','store','');
INSERT INTO t2 VALUES (765,208113,37,'freest','teem','denounces','');
INSERT INTO t2 VALUES (766,208201,37,'Greenberg','kiting','Pyle','FAS');
INSERT INTO t2 VALUES (767,208203,37,'tinting','stodgy','Saxony','');
INSERT INTO t2 VALUES (768,208301,37,'expelled','scalps','serializations','FAS');
INSERT INTO t2 VALUES (769,208302,37,'warm','feed','Peruvian','FAS');
INSERT INTO t2 VALUES (770,208305,37,'smoothed','guitars','taxonomically','FAS');
INSERT INTO t2 VALUES (771,208401,37,'deductions','airships','kingdom','A');
INSERT INTO t2 VALUES (772,208402,37,'Romano','store','stint','A');
INSERT INTO t2 VALUES (773,208403,37,'bitterroot','denounces','Sault','A');
INSERT INTO t2 VALUES (774,208404,37,'corset','Pyle','faithful','');
INSERT INTO t2 VALUES (775,208501,37,'securing','Saxony','Ganymede','FAS');
INSERT INTO t2 VALUES (776,208502,37,'environing','serializations','tidiness','FAS');
INSERT INTO t2 VALUES (777,208503,37,'cute','Peruvian','gainful','FAS');
INSERT INTO t2 VALUES (778,208504,37,'Crays','taxonomically','contrary','FAS');
INSERT INTO t2 VALUES (779,208505,37,'heiress','kingdom','Tipperary','FAS');
INSERT INTO t2 VALUES (780,210101,37,'inform','stint','tropics','W');
INSERT INTO t2 VALUES (781,210102,37,'avenge','Sault','theorizers','');
INSERT INTO t2 VALUES (782,210103,37,'universals','faithful','renew','0');
INSERT INTO t2 VALUES (783,210104,37,'Kinsey','Ganymede','already','');
INSERT INTO t2 VALUES (784,210105,37,'ravines','tidiness','terminal','');
INSERT INTO t2 VALUES (785,210106,37,'bestseller','gainful','Hegelian','');
INSERT INTO t2 VALUES (786,210107,37,'equilibrium','contrary','hypothesizer','');
INSERT INTO t2 VALUES (787,210401,37,'extents','Tipperary','warningly','FAS');
INSERT INTO t2 VALUES (788,213201,37,'relatively','tropics','journalizing','FAS');
INSERT INTO t2 VALUES (789,213203,37,'pressure','theorizers','nested','');
INSERT INTO t2 VALUES (790,213204,37,'critiques','renew','Lars','');
INSERT INTO t2 VALUES (791,213205,37,'befouled','already','saplings','');
INSERT INTO t2 VALUES (792,213206,37,'rightfully','terminal','foothill','');
INSERT INTO t2 VALUES (793,213207,37,'mechanizing','Hegelian','labeled','');
INSERT INTO t2 VALUES (794,216101,37,'Latinizes','hypothesizer','imperiously','FAS');
INSERT INTO t2 VALUES (795,216103,37,'timesharing','warningly','reporters','FAS');
INSERT INTO t2 VALUES (796,218001,37,'Aden','journalizing','furnishings','FAS');
INSERT INTO t2 VALUES (797,218002,37,'embassies','nested','precipitable','FAS');
INSERT INTO t2 VALUES (798,218003,37,'males','Lars','discounts','FAS');
INSERT INTO t2 VALUES (799,218004,37,'shapelessly','saplings','excises','FAS');
INSERT INTO t2 VALUES (800,143503,50,'genres','foothill','Stalin','');
INSERT INTO t2 VALUES (801,218006,37,'mastering','labeled','despot','FAS');
INSERT INTO t2 VALUES (802,218007,37,'Newtonian','imperiously','ripeness','FAS');
INSERT INTO t2 VALUES (803,218008,37,'finishers','reporters','Arabia','');
INSERT INTO t2 VALUES (804,218009,37,'abates','furnishings','unruly','');
INSERT INTO t2 VALUES (805,218010,37,'teem','precipitable','mournfulness','');
INSERT INTO t2 VALUES (806,218011,37,'kiting','discounts','boom','FAS');
INSERT INTO t2 VALUES (807,218020,37,'stodgy','excises','slaughter','A');
INSERT INTO t2 VALUES (808,218021,50,'scalps','Stalin','Sabine','');
INSERT INTO t2 VALUES (809,218022,37,'feed','despot','handy','FAS');
INSERT INTO t2 VALUES (810,218023,37,'guitars','ripeness','rural','');
INSERT INTO t2 VALUES (811,218024,37,'airships','Arabia','organizer','');
INSERT INTO t2 VALUES (812,218101,37,'store','unruly','shipyard','FAS');
INSERT INTO t2 VALUES (813,218102,37,'denounces','mournfulness','civics','FAS');
INSERT INTO t2 VALUES (814,218103,37,'Pyle','boom','inaccuracy','FAS');
INSERT INTO t2 VALUES (815,218201,37,'Saxony','slaughter','rules','FAS');
INSERT INTO t2 VALUES (816,218202,37,'serializations','Sabine','juveniles','FAS');
INSERT INTO t2 VALUES (817,218203,37,'Peruvian','handy','comprised','W');
INSERT INTO t2 VALUES (818,218204,37,'taxonomically','rural','investigations','');
INSERT INTO t2 VALUES (819,218205,37,'kingdom','organizer','stabilizes','A');
INSERT INTO t2 VALUES (820,218301,37,'stint','shipyard','seminaries','FAS');
INSERT INTO t2 VALUES (821,218302,37,'Sault','civics','Hunter','A');
INSERT INTO t2 VALUES (822,218401,37,'faithful','inaccuracy','sporty','FAS');
INSERT INTO t2 VALUES (823,218402,37,'Ganymede','rules','test','FAS');
INSERT INTO t2 VALUES (824,218403,37,'tidiness','juveniles','weasels','');
INSERT INTO t2 VALUES (825,218404,37,'gainful','comprised','CERN','');
INSERT INTO t2 VALUES (826,218407,37,'contrary','investigations','tempering','');
INSERT INTO t2 VALUES (827,218408,37,'Tipperary','stabilizes','afore','FAS');
INSERT INTO t2 VALUES (828,218409,37,'tropics','seminaries','Galatean','');
INSERT INTO t2 VALUES (829,218410,37,'theorizers','Hunter','techniques','W');
INSERT INTO t2 VALUES (830,226001,37,'renew','sporty','error','');
INSERT INTO t2 VALUES (831,226002,37,'already','test','veranda','');
INSERT INTO t2 VALUES (832,226003,37,'terminal','weasels','severely','');
INSERT INTO t2 VALUES (833,226004,37,'Hegelian','CERN','Cassites','FAS');
INSERT INTO t2 VALUES (834,226005,37,'hypothesizer','tempering','forthcoming','');
INSERT INTO t2 VALUES (835,226006,37,'warningly','afore','guides','');
INSERT INTO t2 VALUES (836,226007,37,'journalizing','Galatean','vanish','FAS');
INSERT INTO t2 VALUES (837,226008,37,'nested','techniques','lied','A');
INSERT INTO t2 VALUES (838,226203,37,'Lars','error','sawtooth','FAS');
INSERT INTO t2 VALUES (839,226204,37,'saplings','veranda','fated','FAS');
INSERT INTO t2 VALUES (840,226205,37,'foothill','severely','gradually','');
INSERT INTO t2 VALUES (841,226206,37,'labeled','Cassites','widens','');
INSERT INTO t2 VALUES (842,226207,37,'imperiously','forthcoming','preclude','');
INSERT INTO t2 VALUES (843,226208,37,'reporters','guides','Jobrel','');
INSERT INTO t2 VALUES (844,226209,37,'furnishings','vanish','hooker','');
INSERT INTO t2 VALUES (845,226210,37,'precipitable','lied','rainstorm','');
INSERT INTO t2 VALUES (846,226211,37,'discounts','sawtooth','disconnects','');
INSERT INTO t2 VALUES (847,228001,37,'excises','fated','cruelty','');
INSERT INTO t2 VALUES (848,228004,37,'Stalin','gradually','exponentials','A');
INSERT INTO t2 VALUES (849,228005,37,'despot','widens','affective','A');
INSERT INTO t2 VALUES (850,228006,37,'ripeness','preclude','arteries','');
INSERT INTO t2 VALUES (851,228007,37,'Arabia','Jobrel','Crosby','FAS');
INSERT INTO t2 VALUES (852,228008,37,'unruly','hooker','acquaint','');
INSERT INTO t2 VALUES (853,228009,37,'mournfulness','rainstorm','evenhandedly','');
INSERT INTO t2 VALUES (854,228101,37,'boom','disconnects','percentage','');
INSERT INTO t2 VALUES (855,228108,37,'slaughter','cruelty','disobedience','');
INSERT INTO t2 VALUES (856,228109,37,'Sabine','exponentials','humility','');
INSERT INTO t2 VALUES (857,228110,37,'handy','affective','gleaning','A');
INSERT INTO t2 VALUES (858,228111,37,'rural','arteries','petted','A');
INSERT INTO t2 VALUES (859,228112,37,'organizer','Crosby','bloater','A');
INSERT INTO t2 VALUES (860,228113,37,'shipyard','acquaint','minion','A');
INSERT INTO t2 VALUES (861,228114,37,'civics','evenhandedly','marginal','A');
INSERT INTO t2 VALUES (862,228115,37,'inaccuracy','percentage','apiary','A');
INSERT INTO t2 VALUES (863,228116,37,'rules','disobedience','measures','');
INSERT INTO t2 VALUES (864,228117,37,'juveniles','humility','precaution','');
INSERT INTO t2 VALUES (865,228118,37,'comprised','gleaning','repelled','');
INSERT INTO t2 VALUES (866,228119,37,'investigations','petted','primary','FAS');
INSERT INTO t2 VALUES (867,228120,37,'stabilizes','bloater','coverings','');
INSERT INTO t2 VALUES (868,228121,37,'seminaries','minion','Artemia','A');
INSERT INTO t2 VALUES (869,228122,37,'Hunter','marginal','navigate','');
INSERT INTO t2 VALUES (870,228201,37,'sporty','apiary','spatial','');
INSERT INTO t2 VALUES (871,228206,37,'test','measures','Gurkha','');
INSERT INTO t2 VALUES (872,228207,37,'weasels','precaution','meanwhile','A');
INSERT INTO t2 VALUES (873,228208,37,'CERN','repelled','Melinda','A');
INSERT INTO t2 VALUES (874,228209,37,'tempering','primary','Butterfield','');
INSERT INTO t2 VALUES (875,228210,37,'afore','coverings','Aldrich','A');
INSERT INTO t2 VALUES (876,228211,37,'Galatean','Artemia','previewing','A');
INSERT INTO t2 VALUES (877,228212,37,'techniques','navigate','glut','A');
INSERT INTO t2 VALUES (878,228213,37,'error','spatial','unaffected','');
INSERT INTO t2 VALUES (879,228214,37,'veranda','Gurkha','inmate','');
INSERT INTO t2 VALUES (880,228301,37,'severely','meanwhile','mineral','');
INSERT INTO t2 VALUES (881,228305,37,'Cassites','Melinda','impending','A');
INSERT INTO t2 VALUES (882,228306,37,'forthcoming','Butterfield','meditation','A');
INSERT INTO t2 VALUES (883,228307,37,'guides','Aldrich','ideas','');
INSERT INTO t2 VALUES (884,228308,37,'vanish','previewing','miniaturizes','W');
INSERT INTO t2 VALUES (885,228309,37,'lied','glut','lewdly','');
INSERT INTO t2 VALUES (886,228310,37,'sawtooth','unaffected','title','');
INSERT INTO t2 VALUES (887,228311,37,'fated','inmate','youthfulness','');
INSERT INTO t2 VALUES (888,228312,37,'gradually','mineral','creak','FAS');
INSERT INTO t2 VALUES (889,228313,37,'widens','impending','Chippewa','');
INSERT INTO t2 VALUES (890,228314,37,'preclude','meditation','clamored','');
INSERT INTO t2 VALUES (891,228401,65,'Jobrel','ideas','freezes','');
INSERT INTO t2 VALUES (892,228402,65,'hooker','miniaturizes','forgivably','FAS');
INSERT INTO t2 VALUES (893,228403,65,'rainstorm','lewdly','reduce','FAS');
INSERT INTO t2 VALUES (894,228404,65,'disconnects','title','McGovern','W');
INSERT INTO t2 VALUES (895,228405,65,'cruelty','youthfulness','Nazis','W');
INSERT INTO t2 VALUES (896,228406,65,'exponentials','creak','epistle','W');
INSERT INTO t2 VALUES (897,228407,65,'affective','Chippewa','socializes','W');
INSERT INTO t2 VALUES (898,228408,65,'arteries','clamored','conceptions','');
INSERT INTO t2 VALUES (899,228409,65,'Crosby','freezes','Kevin','');
INSERT INTO t2 VALUES (900,228410,65,'acquaint','forgivably','uncovering','');
INSERT INTO t2 VALUES (901,230301,37,'evenhandedly','reduce','chews','FAS');
INSERT INTO t2 VALUES (902,230302,37,'percentage','McGovern','appendixes','FAS');
INSERT INTO t2 VALUES (903,230303,37,'disobedience','Nazis','raining','');
INSERT INTO t2 VALUES (904,018062,37,'humility','epistle','infest','');
INSERT INTO t2 VALUES (905,230501,37,'gleaning','socializes','compartment','');
INSERT INTO t2 VALUES (906,230502,37,'petted','conceptions','minting','');
INSERT INTO t2 VALUES (907,230503,37,'bloater','Kevin','ducks','');
INSERT INTO t2 VALUES (908,230504,37,'minion','uncovering','roped','A');
INSERT INTO t2 VALUES (909,230505,37,'marginal','chews','waltz','');
INSERT INTO t2 VALUES (910,230506,37,'apiary','appendixes','Lillian','');
INSERT INTO t2 VALUES (911,230507,37,'measures','raining','repressions','A');
INSERT INTO t2 VALUES (912,230508,37,'precaution','infest','chillingly','');
INSERT INTO t2 VALUES (913,230509,37,'repelled','compartment','noncritical','');
INSERT INTO t2 VALUES (914,230901,37,'primary','minting','lithograph','');
INSERT INTO t2 VALUES (915,230902,37,'coverings','ducks','spongers','');
INSERT INTO t2 VALUES (916,230903,37,'Artemia','roped','parenthood','');
INSERT INTO t2 VALUES (917,230904,37,'navigate','waltz','posed','');
INSERT INTO t2 VALUES (918,230905,37,'spatial','Lillian','instruments','');
INSERT INTO t2 VALUES (919,230906,37,'Gurkha','repressions','filial','');
INSERT INTO t2 VALUES (920,230907,37,'meanwhile','chillingly','fixedly','');
INSERT INTO t2 VALUES (921,230908,37,'Melinda','noncritical','relives','');
INSERT INTO t2 VALUES (922,230909,37,'Butterfield','lithograph','Pandora','');
INSERT INTO t2 VALUES (923,230910,37,'Aldrich','spongers','watering','A');
INSERT INTO t2 VALUES (924,230911,37,'previewing','parenthood','ungrateful','');
INSERT INTO t2 VALUES (925,230912,37,'glut','posed','secures','');
INSERT INTO t2 VALUES (926,230913,37,'unaffected','instruments','chastisers','');
INSERT INTO t2 VALUES (927,230914,37,'inmate','filial','icon','');
INSERT INTO t2 VALUES (928,231304,37,'mineral','fixedly','reuniting','A');
INSERT INTO t2 VALUES (929,231305,37,'impending','relives','imagining','A');
INSERT INTO t2 VALUES (930,231306,37,'meditation','Pandora','abiding','A');
INSERT INTO t2 VALUES (931,231307,37,'ideas','watering','omnisciently','');
INSERT INTO t2 VALUES (932,231308,37,'miniaturizes','ungrateful','Britannic','');
INSERT INTO t2 VALUES (933,231309,37,'lewdly','secures','scholastics','A');
INSERT INTO t2 VALUES (934,231310,37,'title','chastisers','mechanics','A');
INSERT INTO t2 VALUES (935,231311,37,'youthfulness','icon','humidly','A');
INSERT INTO t2 VALUES (936,231312,37,'creak','reuniting','masterpiece','');
INSERT INTO t2 VALUES (937,231313,37,'Chippewa','imagining','however','');
INSERT INTO t2 VALUES (938,231314,37,'clamored','abiding','Mendelian','');
INSERT INTO t2 VALUES (939,231315,37,'freezes','omnisciently','jarred','');
INSERT INTO t2 VALUES (940,232102,37,'forgivably','Britannic','scolds','');
INSERT INTO t2 VALUES (941,232103,37,'reduce','scholastics','infatuate','');
INSERT INTO t2 VALUES (942,232104,37,'McGovern','mechanics','willed','A');
INSERT INTO t2 VALUES (943,232105,37,'Nazis','humidly','joyfully','');
INSERT INTO t2 VALUES (944,232106,37,'epistle','masterpiece','Microsoft','');
INSERT INTO t2 VALUES (945,232107,37,'socializes','however','fibrosities','');
INSERT INTO t2 VALUES (946,232108,37,'conceptions','Mendelian','Baltimorean','');
INSERT INTO t2 VALUES (947,232601,37,'Kevin','jarred','equestrian','');
INSERT INTO t2 VALUES (948,232602,37,'uncovering','scolds','Goodrich','');
INSERT INTO t2 VALUES (949,232603,37,'chews','infatuate','apish','A');
INSERT INTO t2 VALUES (950,232605,37,'appendixes','willed','Adlerian','');
INSERT INTO t2 VALUES (5950,1232605,37,'appendixes','willed','Adlerian','');
INSERT INTO t2 VALUES (5951,1232606,37,'appendixes','willed','Adlerian','');
INSERT INTO t2 VALUES (5952,1232607,37,'appendixes','willed','Adlerian','');
INSERT INTO t2 VALUES (5953,1232608,37,'appendixes','willed','Adlerian','');
INSERT INTO t2 VALUES (5954,1232609,37,'appendixes','willed','Adlerian','');
INSERT INTO t2 VALUES (951,232606,37,'raining','joyfully','Tropez','');
INSERT INTO t2 VALUES (952,232607,37,'infest','Microsoft','nouns','');
INSERT INTO t2 VALUES (953,232608,37,'compartment','fibrosities','distracting','');
INSERT INTO t2 VALUES (954,232609,37,'minting','Baltimorean','mutton','');
INSERT INTO t2 VALUES (955,236104,37,'ducks','equestrian','bridgeable','A');
INSERT INTO t2 VALUES (956,236105,37,'roped','Goodrich','stickers','A');
INSERT INTO t2 VALUES (957,236106,37,'waltz','apish','transcontinental','A');
INSERT INTO t2 VALUES (958,236107,37,'Lillian','Adlerian','amateurish','');
INSERT INTO t2 VALUES (959,236108,37,'repressions','Tropez','Gandhian','');
INSERT INTO t2 VALUES (960,236109,37,'chillingly','nouns','stratified','');
INSERT INTO t2 VALUES (961,236110,37,'noncritical','distracting','chamberlains','');
INSERT INTO t2 VALUES (962,236111,37,'lithograph','mutton','creditably','');
INSERT INTO t2 VALUES (963,236112,37,'spongers','bridgeable','philosophic','');
INSERT INTO t2 VALUES (964,236113,37,'parenthood','stickers','ores','');
INSERT INTO t2 VALUES (965,238005,37,'posed','transcontinental','Carleton','');
INSERT INTO t2 VALUES (966,238006,37,'instruments','amateurish','tape','A');
INSERT INTO t2 VALUES (967,238007,37,'filial','Gandhian','afloat','A');
INSERT INTO t2 VALUES (968,238008,37,'fixedly','stratified','goodness','A');
INSERT INTO t2 VALUES (969,238009,37,'relives','chamberlains','welcoming','');
INSERT INTO t2 VALUES (970,238010,37,'Pandora','creditably','Pinsky','FAS');
INSERT INTO t2 VALUES (971,238011,37,'watering','philosophic','halting','');
INSERT INTO t2 VALUES (972,238012,37,'ungrateful','ores','bibliography','');
INSERT INTO t2 VALUES (973,238013,37,'secures','Carleton','decoding','');
INSERT INTO t2 VALUES (974,240401,41,'chastisers','tape','variance','A');
INSERT INTO t2 VALUES (975,240402,41,'icon','afloat','allowed','A');
INSERT INTO t2 VALUES (976,240901,41,'reuniting','goodness','dire','A');
INSERT INTO t2 VALUES (977,240902,41,'imagining','welcoming','dub','A');
INSERT INTO t2 VALUES (978,241801,41,'abiding','Pinsky','poisoning','');
INSERT INTO t2 VALUES (979,242101,41,'omnisciently','halting','Iraqis','A');
INSERT INTO t2 VALUES (980,242102,41,'Britannic','bibliography','heaving','');
INSERT INTO t2 VALUES (981,242201,41,'scholastics','decoding','population','A');
INSERT INTO t2 VALUES (982,242202,41,'mechanics','variance','bomb','A');
INSERT INTO t2 VALUES (983,242501,41,'humidly','allowed','Majorca','A');
INSERT INTO t2 VALUES (984,242502,41,'masterpiece','dire','Gershwins','');
INSERT INTO t2 VALUES (985,246201,41,'however','dub','explorers','');
INSERT INTO t2 VALUES (986,246202,41,'Mendelian','poisoning','libretto','A');
INSERT INTO t2 VALUES (987,246203,41,'jarred','Iraqis','occurred','');
INSERT INTO t2 VALUES (988,246204,41,'scolds','heaving','Lagos','');
INSERT INTO t2 VALUES (989,246205,41,'infatuate','population','rats','');
INSERT INTO t2 VALUES (990,246301,41,'willed','bomb','bankruptcies','A');
INSERT INTO t2 VALUES (991,246302,41,'joyfully','Majorca','crying','');
INSERT INTO t2 VALUES (992,248001,41,'Microsoft','Gershwins','unexpected','');
INSERT INTO t2 VALUES (993,248002,41,'fibrosities','explorers','accessed','A');
INSERT INTO t2 VALUES (994,248003,41,'Baltimorean','libretto','colorful','A');
INSERT INTO t2 VALUES (995,248004,41,'equestrian','occurred','versatility','A');
INSERT INTO t2 VALUES (996,248005,41,'Goodrich','Lagos','cosy','');
INSERT INTO t2 VALUES (997,248006,41,'apish','rats','Darius','A');
INSERT INTO t2 VALUES (998,248007,41,'Adlerian','bankruptcies','mastering','A');
INSERT INTO t2 VALUES (999,248008,41,'Tropez','crying','Asiaticizations','A');
INSERT INTO t2 VALUES (1000,248009,41,'nouns','unexpected','offerers','A');
INSERT INTO t2 VALUES (1001,248010,41,'distracting','accessed','uncles','A');
INSERT INTO t2 VALUES (1002,248011,41,'mutton','colorful','sleepwalk','');
INSERT INTO t2 VALUES (1003,248012,41,'bridgeable','versatility','Ernestine','');
INSERT INTO t2 VALUES (1004,248013,41,'stickers','cosy','checksumming','');
INSERT INTO t2 VALUES (1005,248014,41,'transcontinental','Darius','stopped','');
INSERT INTO t2 VALUES (1006,248015,41,'amateurish','mastering','sicker','');
INSERT INTO t2 VALUES (1007,248016,41,'Gandhian','Asiaticizations','Italianization','');
INSERT INTO t2 VALUES (1008,248017,41,'stratified','offerers','alphabetic','');
INSERT INTO t2 VALUES (1009,248018,41,'chamberlains','uncles','pharmaceutic','');
INSERT INTO t2 VALUES (1010,248019,41,'creditably','sleepwalk','creator','');
INSERT INTO t2 VALUES (1011,248020,41,'philosophic','Ernestine','chess','');
INSERT INTO t2 VALUES (1012,248021,41,'ores','checksumming','charcoal','');
INSERT INTO t2 VALUES (1013,248101,41,'Carleton','stopped','Epiphany','A');
INSERT INTO t2 VALUES (1014,248102,41,'tape','sicker','bulldozes','A');
INSERT INTO t2 VALUES (1015,248201,41,'afloat','Italianization','Pygmalion','A');
INSERT INTO t2 VALUES (1016,248202,41,'goodness','alphabetic','caressing','A');
INSERT INTO t2 VALUES (1017,248203,41,'welcoming','pharmaceutic','Palestine','A');
INSERT INTO t2 VALUES (1018,248204,41,'Pinsky','creator','regimented','A');
INSERT INTO t2 VALUES (1019,248205,41,'halting','chess','scars','A');
INSERT INTO t2 VALUES (1020,248206,41,'bibliography','charcoal','realest','A');
INSERT INTO t2 VALUES (1021,248207,41,'decoding','Epiphany','diffusing','A');
INSERT INTO t2 VALUES (1022,248208,41,'variance','bulldozes','clubroom','A');
INSERT INTO t2 VALUES (1023,248209,41,'allowed','Pygmalion','Blythe','A');
INSERT INTO t2 VALUES (1024,248210,41,'dire','caressing','ahead','');
INSERT INTO t2 VALUES (1025,248211,50,'dub','Palestine','reviver','');
INSERT INTO t2 VALUES (1026,250501,34,'poisoning','regimented','retransmitting','A');
INSERT INTO t2 VALUES (1027,250502,34,'Iraqis','scars','landslide','');
INSERT INTO t2 VALUES (1028,250503,34,'heaving','realest','Eiffel','');
INSERT INTO t2 VALUES (1029,250504,34,'population','diffusing','absentee','');
INSERT INTO t2 VALUES (1030,250505,34,'bomb','clubroom','aye','');
INSERT INTO t2 VALUES (1031,250601,34,'Majorca','Blythe','forked','A');
INSERT INTO t2 VALUES (1032,250602,34,'Gershwins','ahead','Peruvianizes','');
INSERT INTO t2 VALUES (1033,250603,34,'explorers','reviver','clerked','');
INSERT INTO t2 VALUES (1034,250604,34,'libretto','retransmitting','tutor','');
INSERT INTO t2 VALUES (1035,250605,34,'occurred','landslide','boulevard','');
INSERT INTO t2 VALUES (1036,251001,34,'Lagos','Eiffel','shuttered','');
INSERT INTO t2 VALUES (1037,251002,34,'rats','absentee','quotes','A');
INSERT INTO t2 VALUES (1038,251003,34,'bankruptcies','aye','Caltech','');
INSERT INTO t2 VALUES (1039,251004,34,'crying','forked','Mossberg','');
INSERT INTO t2 VALUES (1040,251005,34,'unexpected','Peruvianizes','kept','');
INSERT INTO t2 VALUES (1041,251301,34,'accessed','clerked','roundly','');
INSERT INTO t2 VALUES (1042,251302,34,'colorful','tutor','features','A');
INSERT INTO t2 VALUES (1043,251303,34,'versatility','boulevard','imaginable','A');
INSERT INTO t2 VALUES (1044,251304,34,'cosy','shuttered','controller','');
INSERT INTO t2 VALUES (1045,251305,34,'Darius','quotes','racial','');
INSERT INTO t2 VALUES (1046,251401,34,'mastering','Caltech','uprisings','A');
INSERT INTO t2 VALUES (1047,251402,34,'Asiaticizations','Mossberg','narrowed','A');
INSERT INTO t2 VALUES (1048,251403,34,'offerers','kept','cannot','A');
INSERT INTO t2 VALUES (1049,251404,34,'uncles','roundly','vest','');
INSERT INTO t2 VALUES (1050,251405,34,'sleepwalk','features','famine','');
INSERT INTO t2 VALUES (1051,251406,34,'Ernestine','imaginable','sugars','');
INSERT INTO t2 VALUES (1052,251801,34,'checksumming','controller','exterminated','A');
INSERT INTO t2 VALUES (1053,251802,34,'stopped','racial','belays','');
INSERT INTO t2 VALUES (1054,252101,34,'sicker','uprisings','Hodges','A');
INSERT INTO t2 VALUES (1055,252102,34,'Italianization','narrowed','translatable','');
INSERT INTO t2 VALUES (1056,252301,34,'alphabetic','cannot','duality','A');
INSERT INTO t2 VALUES (1057,252302,34,'pharmaceutic','vest','recording','A');
INSERT INTO t2 VALUES (1058,252303,34,'creator','famine','rouses','A');
INSERT INTO t2 VALUES (1059,252304,34,'chess','sugars','poison','');
INSERT INTO t2 VALUES (1060,252305,34,'charcoal','exterminated','attitude','');
INSERT INTO t2 VALUES (1061,252306,34,'Epiphany','belays','dusted','');
INSERT INTO t2 VALUES (1062,252307,34,'bulldozes','Hodges','encompasses','');
INSERT INTO t2 VALUES (1063,252308,34,'Pygmalion','translatable','presentation','');
INSERT INTO t2 VALUES (1064,252309,34,'caressing','duality','Kantian','');
INSERT INTO t2 VALUES (1065,256001,34,'Palestine','recording','imprecision','A');
INSERT INTO t2 VALUES (1066,256002,34,'regimented','rouses','saving','');
INSERT INTO t2 VALUES (1067,256003,34,'scars','poison','maternal','');
INSERT INTO t2 VALUES (1068,256004,34,'realest','attitude','hewed','');
INSERT INTO t2 VALUES (1069,256005,34,'diffusing','dusted','kerosene','');
INSERT INTO t2 VALUES (1070,258001,34,'clubroom','encompasses','Cubans','');
INSERT INTO t2 VALUES (1071,258002,34,'Blythe','presentation','photographers','');
INSERT INTO t2 VALUES (1072,258003,34,'ahead','Kantian','nymph','A');
INSERT INTO t2 VALUES (1073,258004,34,'reviver','imprecision','bedlam','A');
INSERT INTO t2 VALUES (1074,258005,34,'retransmitting','saving','north','A');
INSERT INTO t2 VALUES (1075,258006,34,'landslide','maternal','Schoenberg','A');
INSERT INTO t2 VALUES (1076,258007,34,'Eiffel','hewed','botany','A');
INSERT INTO t2 VALUES (1077,258008,34,'absentee','kerosene','curs','');
INSERT INTO t2 VALUES (1078,258009,34,'aye','Cubans','solidification','');
INSERT INTO t2 VALUES (1079,258010,34,'forked','photographers','inheritresses','');
INSERT INTO t2 VALUES (1080,258011,34,'Peruvianizes','nymph','stiller','');
INSERT INTO t2 VALUES (1081,258101,68,'clerked','bedlam','t1','A');
INSERT INTO t2 VALUES (1082,258102,68,'tutor','north','suite','A');
INSERT INTO t2 VALUES (1083,258103,34,'boulevard','Schoenberg','ransomer','');
INSERT INTO t2 VALUES (1084,258104,68,'shuttered','botany','Willy','');
INSERT INTO t2 VALUES (1085,258105,68,'quotes','curs','Rena','A');
INSERT INTO t2 VALUES (1086,258106,68,'Caltech','solidification','Seattle','A');
INSERT INTO t2 VALUES (1087,258107,68,'Mossberg','inheritresses','relaxes','A');
INSERT INTO t2 VALUES (1088,258108,68,'kept','stiller','exclaim','');
INSERT INTO t2 VALUES (1089,258109,68,'roundly','t1','implicated','A');
INSERT INTO t2 VALUES (1090,258110,68,'features','suite','distinguish','');
INSERT INTO t2 VALUES (1091,258111,68,'imaginable','ransomer','assayed','');
INSERT INTO t2 VALUES (1092,258112,68,'controller','Willy','homeowner','');
INSERT INTO t2 VALUES (1093,258113,68,'racial','Rena','and','');
INSERT INTO t2 VALUES (1094,258201,34,'uprisings','Seattle','stealth','');
INSERT INTO t2 VALUES (1095,258202,34,'narrowed','relaxes','coinciding','A');
INSERT INTO t2 VALUES (1096,258203,34,'cannot','exclaim','founder','A');
INSERT INTO t2 VALUES (1097,258204,34,'vest','implicated','environing','');
INSERT INTO t2 VALUES (1098,258205,34,'famine','distinguish','jewelry','');
INSERT INTO t2 VALUES (1099,258301,34,'sugars','assayed','lemons','A');
INSERT INTO t2 VALUES (1100,258401,34,'exterminated','homeowner','brokenness','A');
INSERT INTO t2 VALUES (1101,258402,34,'belays','and','bedpost','A');
INSERT INTO t2 VALUES (1102,258403,34,'Hodges','stealth','assurers','A');
INSERT INTO t2 VALUES (1103,258404,34,'translatable','coinciding','annoyers','');
INSERT INTO t2 VALUES (1104,258405,34,'duality','founder','affixed','');
INSERT INTO t2 VALUES (1105,258406,34,'recording','environing','warbling','');
INSERT INTO t2 VALUES (1106,258407,34,'rouses','jewelry','seriously','');
INSERT INTO t2 VALUES (1107,228123,37,'poison','lemons','boasted','');
INSERT INTO t2 VALUES (1108,250606,34,'attitude','brokenness','Chantilly','');
INSERT INTO t2 VALUES (1109,208405,37,'dusted','bedpost','Iranizes','');
INSERT INTO t2 VALUES (1110,212101,37,'encompasses','assurers','violinist','');
INSERT INTO t2 VALUES (1111,218206,37,'presentation','annoyers','extramarital','');
INSERT INTO t2 VALUES (1112,150401,37,'Kantian','affixed','spates','');
INSERT INTO t2 VALUES (1113,248212,41,'imprecision','warbling','cloakroom','');
INSERT INTO t2 VALUES (1114,128026,00,'saving','seriously','gazer','');
INSERT INTO t2 VALUES (1115,128024,00,'maternal','boasted','hand','');
INSERT INTO t2 VALUES (1116,128027,00,'hewed','Chantilly','tucked','');
INSERT INTO t2 VALUES (1117,128025,00,'kerosene','Iranizes','gems','');
INSERT INTO t2 VALUES (1118,128109,00,'Cubans','violinist','clinker','');
INSERT INTO t2 VALUES (1119,128705,00,'photographers','extramarital','refiner','');
INSERT INTO t2 VALUES (1120,126303,00,'nymph','spates','callus','');
INSERT INTO t2 VALUES (1121,128308,00,'bedlam','cloakroom','leopards','');
INSERT INTO t2 VALUES (1122,128204,00,'north','gazer','comfortingly','');
INSERT INTO t2 VALUES (1123,128205,00,'Schoenberg','hand','generically','');
INSERT INTO t2 VALUES (1124,128206,00,'botany','tucked','getters','');
INSERT INTO t2 VALUES (1125,128207,00,'curs','gems','sexually','');
INSERT INTO t2 VALUES (1126,118205,00,'solidification','clinker','spear','');
INSERT INTO t2 VALUES (1127,116801,00,'inheritresses','refiner','serums','');
INSERT INTO t2 VALUES (1128,116803,00,'stiller','callus','Italianization','');
INSERT INTO t2 VALUES (1129,116804,00,'t1','leopards','attendants','');
INSERT INTO t2 VALUES (1130,116802,00,'suite','comfortingly','spies','');
INSERT INTO t2 VALUES (1131,128605,00,'ransomer','generically','Anthony','');
INSERT INTO t2 VALUES (1132,118308,00,'Willy','getters','planar','');
INSERT INTO t2 VALUES (1133,113702,00,'Rena','sexually','cupped','');
INSERT INTO t2 VALUES (1134,113703,00,'Seattle','spear','cleanser','');
INSERT INTO t2 VALUES (1135,112103,00,'relaxes','serums','commuters','');
INSERT INTO t2 VALUES (1136,118009,00,'exclaim','Italianization','honeysuckle','');
INSERT INTO t2 VALUES (5136,1118009,00,'exclaim','Italianization','honeysuckle','');
INSERT INTO t2 VALUES (1137,138011,00,'implicated','attendants','orphanage','');
INSERT INTO t2 VALUES (1138,138010,00,'distinguish','spies','skies','');
INSERT INTO t2 VALUES (1139,138012,00,'assayed','Anthony','crushers','');
INSERT INTO t2 VALUES (1140,068304,00,'homeowner','planar','Puritan','');
INSERT INTO t2 VALUES (1141,078009,00,'and','cupped','squeezer','');
INSERT INTO t2 VALUES (1142,108013,00,'stealth','cleanser','bruises','');
INSERT INTO t2 VALUES (1143,084004,00,'coinciding','commuters','bonfire','');
INSERT INTO t2 VALUES (1144,083402,00,'founder','honeysuckle','Colombo','');
INSERT INTO t2 VALUES (1145,084003,00,'environing','orphanage','nondecreasing','');
INSERT INTO t2 VALUES (1146,088504,00,'jewelry','skies','innocents','');
INSERT INTO t2 VALUES (1147,088005,00,'lemons','crushers','masked','');
INSERT INTO t2 VALUES (1148,088007,00,'brokenness','Puritan','file','');
INSERT INTO t2 VALUES (1149,088006,00,'bedpost','squeezer','brush','');
INSERT INTO t2 VALUES (1150,148025,00,'assurers','bruises','mutilate','');
INSERT INTO t2 VALUES (1151,148024,00,'annoyers','bonfire','mommy','');
INSERT INTO t2 VALUES (1152,138305,00,'affixed','Colombo','bulkheads','');
INSERT INTO t2 VALUES (1153,138306,00,'warbling','nondecreasing','undeclared','');
INSERT INTO t2 VALUES (1154,152701,00,'seriously','innocents','displacements','');
INSERT INTO t2 VALUES (1155,148505,00,'boasted','masked','nieces','');
INSERT INTO t2 VALUES (1156,158003,00,'Chantilly','file','coeducation','');
INSERT INTO t2 VALUES (1157,156201,00,'Iranizes','brush','brassy','');
INSERT INTO t2 VALUES (1158,156202,00,'violinist','mutilate','authenticator','');
INSERT INTO t2 VALUES (1159,158307,00,'extramarital','mommy','Washoe','');
INSERT INTO t2 VALUES (1160,158402,00,'spates','bulkheads','penny','');
INSERT INTO t2 VALUES (1161,158401,00,'cloakroom','undeclared','Flagler','');
INSERT INTO t2 VALUES (1162,068013,00,'gazer','displacements','stoned','');
INSERT INTO t2 VALUES (1163,068012,00,'hand','nieces','cranes','');
INSERT INTO t2 VALUES (1164,068203,00,'tucked','coeducation','masterful','');
INSERT INTO t2 VALUES (1165,088205,00,'gems','brassy','biracial','');
INSERT INTO t2 VALUES (1166,068704,00,'clinker','authenticator','steamships','');
INSERT INTO t2 VALUES (1167,068604,00,'refiner','Washoe','windmills','');
INSERT INTO t2 VALUES (1168,158502,00,'callus','penny','exploit','');
INSERT INTO t2 VALUES (1169,123103,00,'leopards','Flagler','riverfront','');
INSERT INTO t2 VALUES (1170,148026,00,'comfortingly','stoned','sisterly','');
INSERT INTO t2 VALUES (1171,123302,00,'generically','cranes','sharpshoot','');
INSERT INTO t2 VALUES (1172,076503,00,'getters','masterful','mittens','');
INSERT INTO t2 VALUES (1173,126304,00,'sexually','biracial','interdependency','');
INSERT INTO t2 VALUES (1174,068306,00,'spear','steamships','policy','');
INSERT INTO t2 VALUES (1175,143504,00,'serums','windmills','unleashing','');
INSERT INTO t2 VALUES (1176,160201,00,'Italianization','exploit','pretenders','');
INSERT INTO t2 VALUES (1177,148028,00,'attendants','riverfront','overstatements','');
INSERT INTO t2 VALUES (1178,148027,00,'spies','sisterly','birthed','');
INSERT INTO t2 VALUES (1179,143505,00,'Anthony','sharpshoot','opportunism','');
INSERT INTO t2 VALUES (1180,108014,00,'planar','mittens','showroom','');
INSERT INTO t2 VALUES (1181,076104,00,'cupped','interdependency','compromisingly','');
INSERT INTO t2 VALUES (1182,078106,00,'cleanser','policy','Medicare','');
INSERT INTO t2 VALUES (1183,126102,00,'commuters','unleashing','corresponds','');
INSERT INTO t2 VALUES (1184,128029,00,'honeysuckle','pretenders','hardware','');
INSERT INTO t2 VALUES (1185,128028,00,'orphanage','overstatements','implant','');
INSERT INTO t2 VALUES (1186,018410,00,'skies','birthed','Alicia','');
INSERT INTO t2 VALUES (1187,128110,00,'crushers','opportunism','requesting','');
INSERT INTO t2 VALUES (1188,148506,00,'Puritan','showroom','produced','');
INSERT INTO t2 VALUES (1189,123303,00,'squeezer','compromisingly','criticizes','');
INSERT INTO t2 VALUES (1190,123304,00,'bruises','Medicare','backer','');
INSERT INTO t2 VALUES (1191,068504,00,'bonfire','corresponds','positively','');
INSERT INTO t2 VALUES (1192,068305,00,'Colombo','hardware','colicky','');
INSERT INTO t2 VALUES (1193,000000,00,'nondecreasing','implant','thrillingly','');

--
-- Search with a key
--

select t2.fld3 FROM t2 where companynr = 58 and fld3 like "%imaginable%";
select fld3 FROM t2 where fld3 like "%cultivation" ;

--
-- Search with a key using sorting and limit the same time
--

select t2.fld3,companynr FROM t2 where companynr = 57+1 order by fld3;
select fld3,companynr FROM t2 where companynr = 58 order by fld3;

select fld3 FROM t2 order by fld3 desc limit 10;
select fld3 FROM t2 order by fld3 desc limit 5;
select fld3 FROM t2 order by fld3 desc limit 5,5;

--
-- Search with a key having a constant with each unique key.
-- The table is read directly with read-next on fld3
--

select t2.fld3 FROM t2 where fld3 = 'honeysuckle';
select t2.fld3 FROM t2 where fld3 LIKE 'honeysuckl_';
select t2.fld3 FROM t2 where fld3 LIKE 'hon_ysuckl_';
select t2.fld3 FROM t2 where fld3 LIKE 'honeysuckle%';
select t2.fld3 FROM t2 where fld3 LIKE 'h%le';

select t2.fld3 FROM t2 where fld3 LIKE 'honeysuckle_';
select t2.fld3 FROM t2 where fld3 LIKE 'don_t_find_me_please%';

--
-- Test sorting with a used key (there is no need for sorting)
--

select t2.fld3 FROM t2 where fld3 >= 'honeysuckle' and fld3 <= 'honoring' order by fld3;
select fld1,fld3 FROM t2 where fld3="Colombo" or fld3 = "nondecreasing" order by fld3;

--
-- Search with a key with LIKE constant
-- If the like starts with a certain letter key will be used.
--

select fld1,fld3 FROM t2 where companynr = 37 and fld3 like 'f%';
select fld3 FROM t2 where fld3 like "L%" and fld3 = "ok";
select fld3 FROM t2 where (fld3 like "C%" and fld3 = "Chantilly");
select fld1,fld3 FROM t2 where fld1 like "25050%";
select fld1,fld3 FROM t2 where fld1 like "25050_";


--
-- Test rename of table
--
CREATE TABLE t3 engine=archive select * FROM t2;
select * FROM t3 where fld3='bonfire';
select count(*) FROM t3;
select * FROM t4 where fld3='bonfire';
select count(*) FROM t4;

-- End of 4.1 tests

--
-- Test for insert after select
--
INSERT INTO t2 VALUES (1,000001,00,'Omaha','teethe','neat','');
INSERT INTO t2 VALUES (2,011401,37,'breaking','dreaded','Steinberg','W');
INSERT INTO t2 VALUES (3,011402,37,'Romans','scholastics','jarring','');
INSERT INTO t2 VALUES (4,011403,37,'intercepted','audiology','tinily','');
SELECT * FROM t2;
SELECT * FROM t2;
INSERT INTO t2 VALUES (2,011401,37,'breaking','dreaded','Steinberg','W');
INSERT INTO t2 VALUES (3,011402,37,'Romans','scholastics','jarring','');
INSERT INTO t2 VALUES (4,011403,37,'intercepted','audiology','tinily','');
SELECT * FROM t2;
SELECT * FROM t2;

--
-- Test bulk inserts
INSERT INTO t2 VALUES (1,000001,00,'Omaha','teethe','neat','') , (2,011401,37,'breaking','dreaded','Steinberg','W') , (3,011402,37,'Romans','scholastics','jarring','') , (4,011403,37,'intercepted','audiology','tinily','');
SELECT * FROM t2;

--
-- For bug #12836
-- Delete was allowing all rows to be removed
--error 1031
DELETE FROM t2;
SELECT * FROM t2;
INSERT INTO t2 VALUES (2,011401,37,'breaking','dreaded','Steinberg','W');
INSERT INTO t2 VALUES (3,011402,37,'Romans','scholastics','jarring','');
INSERT INTO t2 VALUES (4,011403,37,'intercepted','audiology','tinily','');
SELECT * FROM t2;
SELECT * FROM t2;

-- Adding support for CHECK table
CHECK TABLE t2;
SELECT * FROM t2;

-- Adding test for ALTER TABLE
ALTER TABLE t2 DROP COLUMN fld6;
SELECT * FROM t2 WHERE auto != 100000;


-- Adding tests for autoincrement
-- First the simple stuff

CREATE TABLE `t5` (
`a` int(11) NOT NULL auto_increment,
b char(12),
PRIMARY KEY  (`a`)
)  DEFAULT CHARSET=latin1;

INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (32, "foo");
INSERT INTO t5 VALUES (23, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (3, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
SELECT * FROM t5;

SELECT * FROM t5 WHERE a=3;

DROP TABLE t5;

CREATE TABLE `t5` (
`a` int(11) NOT NULL auto_increment,
b char(12),
KEY  (`a`)
)  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5;

INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (32, "foo");
INSERT INTO t5 VALUES (23, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (3, "foo");
INSERT INTO t5 VALUES (NULL, "foo");
SELECT * FROM t5;
SELECT * FROM t5;

SELECT * FROM t5 WHERE a=32;
SELECT * FROM t5 WHERE a=3;

DROP TABLE t5;

CREATE TABLE `t5` (
`a` int(11) NOT NULL auto_increment,
b blob(12),
KEY  (`a`)
)  DEFAULT CHARSET=latin1;

INSERT INTO t5 VALUES (NULL, "foo");
INSERT INTO t5 VALUES (NULL, "We the people");
INSERT INTO t5 VALUES (NULL, "in order to form a more pefect union");
INSERT INTO t5 VALUES (NULL, "establish justice");
INSERT INTO t5 VALUES (NULL, "foo grok ");
INSERT INTO t5 VALUES (32, "ensure domestic tranquility");
INSERT INTO t5 VALUES (23, "provide for the common defense");
INSERT INTO t5 VALUES (NULL, "fo fooo");
INSERT INTO t5 VALUES (NULL, "foo just naother bit of text");
INSERT INTO t5 VALUES (3, "foo this is mine to think about");
INSERT INTO t5 VALUES (NULL, "promote the general welfare");
SELECT * FROM t5;
SELECT b FROM t5;
SELECT b FROM t5 WHERE a =3;
SELECT b FROM t5 WHERE a IN (32, 23, 5);

DROP TABLE t5;

CREATE TABLE `t5` (
`a` int(11) NOT NULL auto_increment,
b blob(12),
c blob(12),
KEY  (`a`)
)  DEFAULT CHARSET=latin1;

INSERT INTO t5 VALUES (NULL, "foo", "grok this!");
INSERT INTO t5 VALUES (NULL, "We the people", NULL);
INSERT INTO t5 VALUES (NULL, "in order to form a more peefect union", "secure the blessing of liberty");
INSERT INTO t5 VALUES (NULL, "establish justice", "to ourselves and");
INSERT INTO t5 VALUES (32, "ensure domestic tranquility", NULL);
INSERT INTO t5 VALUES (23, "provide for the common defense", "posterity");
INSERT INTO t5 VALUES (NULL, "promote the general welfare", "do ordain");
SELECT * FROM t5;
SELECT b FROM t5;
SELECT b FROM t5 WHERE a =3;
SELECT b FROM t5 WHERE a IN (32, 23, 5);
SELECT c FROM t5;
SELECT c FROM t5 WHERE a =3;
SELECT c FROM t5 WHERE a IN (32, 23, 5);

-- Adding this in case someone tries to add fast ALTER TABLE and doesn't tes
-- it.
-- Some additional tests for new, faster ALTER TABLE.  Note that most of the
-- whole ALTER TABLE code is being tested all around the test suite already.
--

DROP TABLE t1;
CREATE TABLE t1 (v varchar(32)) ;
insert into t1 values ('def'),('abc'),('hij'),('3r4f');
select * from t1;
ALTER TABLE t1 change v v2 varchar(32);
select * from t1;
ALTER TABLE t1 change v2 v varchar(64);
select * from t1;
ALTER TABLE t1 add i int auto_increment not null primary key first;
select * from t1;

-- Testing cleared row key
DROP TABLE t5;

CREATE TABLE `t5` (
`a` int(11) NOT NULL auto_increment,
b varchar(250),
c varchar(800),
KEY  (`a`)
)  DEFAULT CHARSET=latin1;

INSERT INTO t5 VALUES (NULL, "foo", "grok this!");
INSERT INTO t5 VALUES (NULL, "We the people", NULL);
INSERT INTO t5 VALUES (NULL, "in order to form a more peefect union", "secure the blessing of liberty");
INSERT INTO t5 VALUES (NULL, "establish justice", "to ourselves and");
INSERT INTO t5 VALUES (32, "ensure domestic tranquility", NULL);
INSERT INTO t5 VALUES (23, "provide for the common defense", "posterity");
INSERT INTO t5 VALUES (NULL, "promote the general welfare", "do ordain");
INSERT IGNORE INTO t5 VALUES (NULL, "abcdeghijklmnopqrstuvwxyzabcdeghijklmnopqrstuvwxyzabcdeghijklmnopqrstuvwxyzabcdeghijklmnopqrstuvwxyzabcdeghijklmnopqrstuvwxyzabcdeghijklmnopqrstuvwxyzabcdeghijklmnopqrstuvwxyzabcdeghijklmnopqrstuvwxyzabcdeghijklmnopqrstuvwxyzabcdeghijklmnopqrstuvwxyzabc", "do ordain");

SELECT * FROM t5;

CREATE TABLE `t6` (
`a` int(11) NOT NULL auto_increment,
b blob(12),
c int,
KEY  (`a`)
)  DEFAULT CHARSET=latin1;
SELECT * FROM t6;
INSERT INTO t6 VALUES (NULL, "foo", NULL);
INSERT INTO t6 VALUES (NULL, "We the people", 5);
INSERT INTO t6 VALUES (NULL, "in order to form a more pefect union", 9);
INSERT INTO t6 VALUES (NULL, "establish justice", NULL);
INSERT INTO t6 VALUES (NULL, NULL, NULL);
INSERT INTO t6 VALUES (32, "ensure domestic tranquility", NULL);
INSERT INTO t6 VALUES (23, "provide for the common defense", 30);
INSERT INTO t6 VALUES (NULL, "fo fooo", 70);
INSERT INTO t6 VALUES (NULL, NULL, 98);
INSERT INTO t6 VALUES (NULL, "promote the general welfare", 50);
SELECT * FROM t6;
SELECT * FROM t6 ORDER BY a;
SELECT * FROM t6 ORDER BY a DESC;


-- 
-- Cleanup, test is over
--


--disable_warnings
DROP TABLE t1, t2, t4, t5, t6;

--
-- BUG#26138 - REPAIR TABLE with option USE_FRM erases all records in ARCHIVE
--             table
--
create table t1 (i int) engine=archive;
insert into t1 values (1);
select * from t1;
drop table t1;

--
-- BUG#29207 - archive table reported as corrupt by check table
--
create table t1(a longblob) engine=archive;
insert into t1 set a='';
insert into t1 set a='a';
drop table t1;

--
-- BUG#31036 - Using order by with archive table crashes server
--

CREATE TABLE t1(a VARCHAR(510)) ENGINE = ARCHIVE;

let $bug31036=41;
{
  INSERT INTO t1(a) VALUES (REPEAT('a', 510));
  dec $bug31036;
INSERT INTO t1(a) VALUES ('');
SELECT * FROM t1 ORDER BY a;

DROP TABLE t1;

--
-- BUG#31833 -  ORDER BY leads to wrong result when ARCHIVE, BLOB and table
--              cache is full
--
CREATE TABLE t1(a INT NOT NULL AUTO_INCREMENT, b BLOB, KEY(a)) ENGINE=archive;
INSERT INTO t1 VALUES (NULL, NULL),(NULL, NULL);
SELECT * FROM t1 ORDER BY a;
DROP TABLE t1;

--
-- BUG#29203 - archive tables have weird values in show table status
--
CREATE TABLE t1(a INT, b BLOB) ENGINE=archive;
SELECT DATA_LENGTH, AVG_ROW_LENGTH FROM
  INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='t1' AND TABLE_SCHEMA='test';
INSERT INTO t1 VALUES(1, 'sampleblob1'),(2, 'sampleblob2');
SELECT DATA_LENGTH, AVG_ROW_LENGTH FROM
  INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='t1' AND TABLE_SCHEMA='test';
DROP TABLE t1;

--
-- BUG#46961 - archive engine loses rows during self joining select!
--
SET @save_join_buffer_size= @@join_buffer_size;
SET @@join_buffer_size= 8192;
CREATE TABLE t1(a CHAR(255)) ENGINE=archive;
INSERT INTO t1 VALUES('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
                     ('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
                     ('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
SELECT COUNT(t1.a) FROM t1, t1 a, t1 b, t1 c, t1 d, t1 e;
DROP TABLE t1;
SET @@join_buffer_size= @save_join_buffer_size;

--
-- BUG#40677 - Archive tables joined on primary return no result
--
CREATE TABLE t1(id INT NOT NULL AUTO_INCREMENT, name VARCHAR(128) NOT NULL, PRIMARY KEY(id)) ENGINE=archive;
INSERT INTO t1 VALUES(NULL,'a'),(NULL,'a');
CREATE TABLE t2(id INT NOT NULL AUTO_INCREMENT, name VARCHAR(128) NOT NULL, PRIMARY KEY(id)) ENGINE=archive;
INSERT INTO t2 VALUES(NULL,'b'),(NULL,'b');
SELECT t1.id, t2.id, t1.name, t2.name FROM t1,t2 WHERE t1.id = t2.id;
DROP TABLE t1,t2;
CREATE TABLE t1(a INT) ENGINE=ARCHIVE;
SELECT * FROM t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT) ENGINE=ARCHIVE;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1(a INT) ENGINE=archive;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
SET sort_buffer_size=32804;
CREATE TABLE t1(a INT, b CHAR(255), c CHAR(255), d CHAR(255),
  e CHAR(255), f INT) ENGINE=ARCHIVE DEFAULT CHARSET utf8mb3;
INSERT INTO t1 VALUES(-1,'b','c','d','e',1);
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT t1.* FROM t1,t1 t2,t1 t3,t1 t4,t1 t5,t1 t6;
SELECT * FROM t1 ORDER BY f LIMIT 1;
DROP TABLE t1;
SET sort_buffer_size=DEFAULT;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (c1 decimal(19,14) NOT NULL) ENGINE=ARCHIVE;
SET sql_mode='NO_ENGINE_SUBSTITUTION';
CREATE INDEX i1 ON t1(c1);
SET sql_mode= default;
DROP TABLE t1;
CREATE TABLE t1(a BLOB, b VARCHAR(200)) ENGINE=ARCHIVE;
INSERT INTO t1 VALUES(NULL, '');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT) ENGINE=ARCHIVE;
CREATE TABLE t2 SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t (j JSON) ENGINE=ARCHIVE;
INSERT INTO t VALUES ('{}');
UPDATE t SET j = '[1]';
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE archive_table (id INT, x INT) ENGINE=ARCHIVE;
CREATE TABLE innodb_table (id INT PRIMARY KEY, x INT) ENGINE=InnoDB;
CREATE VIEW v AS SELECT * FROM archive_table;
DELETE FROM archive_table;
DELETE FROM v;
DELETE t1, t2 FROM archive_table AS t1, innodb_table AS t2
       WHERE t1.id = t2.id;
DELETE t1 FROM v AS t1, innodb_table AS t2 WHERE t1.id = t2.id;
UPDATE archive_table SET x = 1000;
UPDATE archive_table AS t1, innodb_table AS t2
       SET t1.x = 1000, t2.x = 2000 WHERE t1.id = t2.id;
UPDATE v SET x = 1000;
UPDATE v AS t1, innodb_table AS t2
       SET t1.x = 1000, t2.x = 2000 WHERE t1.id = t2.id;

INSERT INTO archive_table VALUES (1, 1), (2, 2), (3, 3);
INSERT INTO innodb_table VALUES (1, 2), (3, 4), (5, 6);
UPDATE archive_table SET x = 1 WHERE id = 1;
UPDATE archive_table SET x = x + 1 WHERE FALSE;
UPDATE archive_table AS t1, innodb_table AS t2
       SET t1.x = 1, t2.x = 2
       WHERE t1.id = t2.id AND t1.id = 1;
UPDATE v SET x = 1 WHERE id = 1;
UPDATE v AS t1, innodb_table AS t2
       SET t1.x = 1, t2.x = 2
       WHERE t1.id = t2.id AND t1.id = 1;
UPDATE archive_table SET x = x + 1;
UPDATE archive_table SET x = NULL;
UPDATE archive_table AS t1, innodb_table AS t2
       SET t1.x = t1.x + 1, t2.x = t2.x + 1
       WHERE t1.id = t2.id AND t1.id = 1;
UPDATE v SET x = x + 1 WHERE id = 1;
UPDATE v AS t1, innodb_table AS t2
       SET t1.x = t1.x + 1, t2.x = t2.x + 1
       WHERE t1.id = t2.id AND t1.id = 1;

SELECT * FROM archive_table ORDER BY id;
SELECT * FROM innodb_table ORDER BY id;
UPDATE archive_table AS t1, innodb_table AS t2
       SET t2.x = t2.x + 1 WHERE t1.id = t2.id;
SELECT * FROM archive_table ORDER BY id;
SELECT * FROM innodb_table ORDER BY id;
DELETE FROM archive_table;
DELETE FROM v;
DELETE t1, t2 FROM archive_table AS t1, innodb_table AS t2
       WHERE t1.id = t2.id;
DELETE t1 FROM v AS t1, innodb_table AS t2 WHERE t1.id = t2.id;

SELECT * FROM archive_table ORDER BY id;
SELECT * FROM innodb_table ORDER BY id;
DELETE t2 FROM archive_table AS t1, innodb_table AS t2 WHERE t1.id = t2.id;
SELECT * FROM archive_table ORDER BY id;
SELECT * FROM innodb_table ORDER BY id;

DROP VIEW v;
DROP TABLE archive_table, innodb_table;
