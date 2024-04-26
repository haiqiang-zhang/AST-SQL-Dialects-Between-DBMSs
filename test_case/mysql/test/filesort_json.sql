
CREATE TABLE `F` (
  `col_int_key` int(11) DEFAULT NULL,
  `col_date_key` date DEFAULT NULL,
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `col_varchar_10_utf8` varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  `col_int` int(11) DEFAULT NULL,
  `col_varchar_255_latin1` varchar(255) DEFAULT NULL,
  `col_varchar_255_latin1_key` varchar(255) DEFAULT NULL,
  `col_datetime` datetime DEFAULT NULL,
  `col_varchar_255_utf8_key` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `col_int_key` (`col_int_key`),
  KEY `col_date_key` (`col_date_key`),
  KEY `col_varchar_255_latin1_key` (`col_varchar_255_latin1_key`),
  KEY `col_varchar_255_utf8_key` (`col_varchar_255_utf8_key`)
);


INSERT INTO `F` (`col_int_key`, `col_date_key`, `pk`, `col_varchar_10_utf8`, `col_int`, `col_varchar_255_latin1`, `col_varchar_255_latin1_key`, `col_datetime`, `col_varchar_255_utf8_key`)
VALUES (-249954304,'2004-03-26',1,'y',-26214400,'s','s','2007-01-07 07:51:07','jyzcdrxgpqcseravocjjhqvpxnvxqvapilzrfmaafmpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlm'),
(-1537146880,'0000-00-00',2,'yzcdrxgpqc',985006080,'got','zcdrxgpqcseravocjjhqvpxnvxqvapilzrfmaafmpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlr','0000-00-00 00:00:00','rxgpqcseravocjjhqvpxnvxqvapilzrfmaafmpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralr'),
(1037959168,'2000-01-01',3,'xgpqcserav',1894580224,'gpqcseravocjjhqvpxnvxqvapilzrfmaafmpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgo','UHHMT','2007-06-17 00:00:00','UGRDE'),
(8,'2000-07-08',4,'pqcseravoc',5,'she','qcseravocjjhqvpxnvxqvapilzrfmaafmpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogn','2009-04-02 00:00:00','now'),
(7,'2002-07-05',5,'CDFDD',404684800,'o','TOSPB','0000-00-00 00:00:00','to'),
(3,'2001-01-16',6,'q',7,'all','q','0000-00-00 00:00:00','get'),
(-92864512,'2006-07-13',7,'i',-2058813440,'in','not','0000-00-00 00:00:00','going'),
(1,'0000-00-00',8,'KDKWB',-1295253504,'in','AOVOK','0000-00-00 00:00:00','v'),
(9,'2005-06-04',9,'jhqvpxnvxq',-72286208,'and','tell','2000-09-28 02:36:56','are'),
(7,'2004-08-28',10,'u',265486336,'EQGOJ','j','2005-06-03 14:30:51','i'),
(-1898643456,'0000-00-00',11,'do',1971322880,'vpxnvxqvapilzrfmaafmpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejl','CCACG','2002-11-01 01:04:05','on'),
(-1296105472,'2009-01-26',12,'xnvxqvapil',-1863647232,'NTIIH','EUHAD','0000-00-00 00:00:00','BLJRH'),
(1447362560,'2000-05-09',13,'a',160235520,'nvxqvapilzrfmaafmpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluaz','see','2000-06-08 05:49:25','right'),
(2,'0000-00-00',14,'up',8,'XJJSQ','ETQLI','2002-12-20 00:00:00','LDSDF'),
(-1044905984,'2003-02-24',15,'apilzrfmaa',3,'not','w','2009-06-19 07:08:18','ilzrfmaafmpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmh'),
(1186594816,'2004-03-17',16,'VICVZ',4,'zrfmaafmpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxr','back','0000-00-00 00:00:00','NARLK'),
(-1870397440,'2004-03-16',17,'w',3,'RBXRV','go','2009-11-11 00:00:00','it'),
(-956760064,'2001-09-20',18,'HERHT',1135017984,'like','KIEKD','2008-09-19 10:38:16','mpuqxyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokus'),
(629080064,'2003-01-02',19,'h',9,'OEPHU','RVQGK','2008-05-22 00:38:28','some'),
(-2127626240,'0000-00-00',20,'qxyqlwlcsj',7,'y','j','0000-00-00 00:00:00','xyqlwlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvny'),
(2068381696,'0000-00-00',21,'qlwlcsjqsl',1678180352,'you''re','can','2000-06-23 00:00:00','something'),
(7,'2002-04-11',22,'UJWYO',4,'wlcsjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmw','YNLBL','0000-00-00 00:00:00','csjqslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcp'),
(982319104,'0000-00-00',23,'VABLP',7,'s','QTSDS','0000-00-00 00:00:00','is'),
(-1500381184,'0000-00-00',24,'I''m',0,'qslcqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxht','m','2004-08-20 00:00:00','z'),
(-1040908288,'2001-12-09',25,'slcqeitway',6,'n','what','0000-00-00 00:00:00','MQQCN'),
(1,'0000-00-00',26,'SKDGV',58785792,'cqeitwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovz','JPGWD','2004-01-03 14:04:39','right'),
(4,'2003-04-14',27,'qeitwaymbl',770703360,'eitwaymblfvnmnzxjwesqgczkydqadbimgufj','itwaymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslv','2003-02-17 00:00:00','b'),
(9,'2009-02-14',28,'NVRWC',5,'waymblfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzw','t','2005-11-10 00:00:00','on'),
(1,'2009-02-12',29,'at',-795213824,'y','HFSIZ','2006-10-05 00:00:00','at'),
(99090432,'2006-10-04',30,'KFUSS',86376448,'u','QCPRY','0000-00-00 00:00:00','XCWYN'),
(747044864,'2001-12-09',31,'TYCGQ',1314783232,'blfvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaurs','d','2005-07-21 00:00:00','at'),
(278396928,'2003-04-22',32,'r',-533200896,'h','fvnmnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursra','2009-02-25 00:00:00','it'),
(6,'2009-10-13',33,'nmnzxjwesq',1870397440,'x','mnzxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwq','0000-00-00 00:00:00','up'),
(2,'0000-00-00',34,'nzxjwesqgc',-166920192,'zxjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyr','xjwesqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqt','2001-11-27 06:07:47','FMILB'),
(-1851588608,'2002-07-16',35,'wesqgczkyd',-1594556416,'ok','j','2006-04-15 14:15:55','p'),
(7,'2007-05-16',36,'p',0,'OMDMD','sqgczkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjaw','2007-08-28 05:26:38','go'),
(9,'2006-09-25',37,'you''re',-538116096,'don''t','ZPLLG','0000-00-00 00:00:00','no'),
(7,'0000-00-00',38,'gczkydqadb',4,'czkydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmh','YNDJJ','0000-00-00 00:00:00','ydqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqae'),
(2,'0000-00-00',39,'his',4,'on','g','2009-09-13 10:47:14','can'),
(3,'0000-00-00',40,'l',-1166999552,'KKHLO','dqadbimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaia','2001-02-14 00:00:00','when'),
(7,'2009-03-28',41,'back',1,'SJECM','CXIJP','0000-00-00 00:00:00','s'),
(-1837760512,'2009-05-14',42,'IVYEU',1126105088,'VFSQX','out','0000-00-00 00:00:00','WVXHO'),
(9,'2000-10-02',43,'CGMKV',-966197248,'LGKUP','bimgufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetp','2005-01-25 00:00:00','SYFWG'),
(993918976,'2008-11-05',44,'not',4,'we','DDDJN','0000-00-00 00:00:00','ABSRU'),
(-1699545088,'2008-12-01',45,'his',0,'ufjtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunck','was','2006-06-16 06:50:41','her'),
(-1450442752,'2009-12-13',46,'DAUGN',3,'j','p','2009-08-13 00:00:00','c'),
(-460259328,'0000-00-00',47,'LQPHD',6,'jtuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckia','was','0000-00-00 00:00:00','LFEJT'),
(6,'2002-12-07',48,'LCMWA',0,'tuxjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiav','RFKCT','0000-00-00 00:00:00','GRVPY'),
(1884160000,'0000-00-00',49,'JUTUT',-1671495680,'g','xjjtfuxnlmiynpmhqnkevltfwztnkbqtmvhifivfltalamuhzjxxhthcdglaqqqolnjlyuhtozfikxzqaenhiwbcorbhpmottsptnsdhvkapsiloqplymbhtjecmundrxotbojyomojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavne','0000-00-00 00:00:00','x'),
(1,'0000-00-00',50,'q',1,'BEFTQ','but','2007-08-19 00:00:00','what');

CREATE TABLE `H` (
  `col_date_key` date DEFAULT NULL,
  `col_int` int(11) DEFAULT NULL,
  `col_int_key` int(11) DEFAULT NULL,
  `col_varchar_255_latin1` varchar(255) DEFAULT NULL,
  `col_varchar_255_utf8_key` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `col_varchar_10_utf8` varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `col_datetime` datetime DEFAULT NULL,
  `col_varchar_255_latin1_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `col_date_key` (`col_date_key`),
  KEY `col_int_key` (`col_int_key`),
  KEY `col_varchar_255_utf8_key` (`col_varchar_255_utf8_key`),
  KEY `col_varchar_255_latin1_key` (`col_varchar_255_latin1_key`)
);


INSERT INTO `H` (`col_date_key`, `col_int`, `col_int_key`, `col_varchar_255_latin1`, `col_varchar_255_utf8_key`, `col_varchar_10_utf8`, `pk`, `col_datetime`, `col_varchar_255_latin1_key`)
VALUES ('2005-10-18',4,543424512,'we','back','good',1,'2005-08-26 00:00:00','w'),
('2007-02-04',-1116798976,9,'TCFTO','omojnzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqb','mojnzjxgkw',2,'0000-00-00 00:00:00','didn''t'),
('2007-06-19',9,1859715072,'OPOCU','DMXGQ','ojnzjxgkwg',3,'2000-01-26 19:48:13','been'),
('0000-00-00',7,0,'BKSVC','AYFDD','jnzjxgkwgq',4,'0000-00-00 00:00:00','with'),
('2001-03-26',4,7,'MMBAX','the','because',5,'2006-04-19 21:46:29','t'),
('0000-00-00',6,1040187392,'is','nzjxgkwgqjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpy','t',6,'0000-00-00 00:00:00','that''s'),
('0000-00-00',-793247744,6,'really','EIWGX','zjxgkwgqjc',7,'0000-00-00 00:00:00','q'),
('2004-01-23',5,6,'when','j','gkwgqjcrib',8,'2007-11-17 17:18:52','NTYUK'),
('2002-10-19',7,4,'t','KAZEJ','do',9,'2008-09-25 13:30:04','d'),
('0000-00-00',-460324864,-682164224,'qjcribqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpip','w','ok',10,'2001-05-14 08:21:38','IVFMU'),
('2000-03-17',8,-2074935296,'e','not','h',11,'2003-07-11 07:45:11','ibqzlmlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocn'),
('2003-12-03',691666944,1965031424,'there','PXLKZ','lmlralrgog',12,'0000-00-00 00:00:00','YEKOJ'),
('2007-11-17',-1586102272,3,'mlralrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqby','really','when',13,'2001-11-04 13:54:24','you'),
('2009-12-27',208535552,1205665792,'g','alrgogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqa','t',14,'2001-07-01 00:00:00','EEHAA'),
('0000-00-00',4,-668729344,'gogncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcw','just','oh',15,'2006-05-23 19:57:55','MEIKL'),
('2009-01-04',-479264768,-1466695680,'AFDJL','r','APOZK',16,'2007-08-04 00:00:00','SMIOK'),
('0000-00-00',6,574619648,'come','f','GSPBA',17,'2009-07-13 16:55:17','WWACE'),
('2000-01-26',1645477888,4,'u','BQPBX','WHCBN',18,'0000-00-00 00:00:00','XFXMG'),
('2006-12-19',-884408320,2,'was','MEKKE','BHKDI',19,'2006-12-09 00:00:00','hey'),
('0000-00-00',-2006515712,-1009909760,'with','d','my',20,'2002-05-19 00:00:00','in'),
('2004-07-20',-1062928384,1761280000,'ncaaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwyp','no','IYHLZ',21,'0000-00-00 00:00:00','aaktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgd'),
('2005-12-14',7,9,'from','e','aktefqgrej',22,'0000-00-00 00:00:00','ktefqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdz'),
('2003-04-09',-27787264,-1634992128,'p','BLDQK','d',23,'2009-03-15 21:11:42','ETNHA'),
('2007-11-04',-906166272,1,'d','back','t',24,'2004-10-18 09:04:20','efqgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrx'),
('2005-10-01',-1422589952,4,'YXIJT','qgrejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxex','hey',25,'2006-05-11 08:30:57','grejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexd'),
('0000-00-00',-1090453504,2,'VBPHB','t','be',26,'2005-01-24 00:00:00','v'),
('2000-06-19',-2048131072,7,'good','RNRKX','r',27,'0000-00-00 00:00:00','ejluazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkp'),
('0000-00-00',9,5,'luazkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppz','c','GNVJE',28,'2007-11-01 00:00:00','azkmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactq'),
('2000-04-08',2,8,'kmbvctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzm','r','mbvctkxreh',29,'2004-05-21 00:00:00','n'),
('2002-07-21',9,0,'I''ll','MSIHU','vctkxrehdo',30,'2000-01-20 00:00:00','v'),
('2001-04-23',-1786249216,2,'yes','ctkxrehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacf','x',31,'0000-00-00 00:00:00','PNANI'),
('0000-00-00',8,5,'RKDSC','he','d',32,'2007-09-10 00:00:00','look'),
('0000-00-00',11468800,1758265344,'had','l','DNVJI',33,'0000-00-00 00:00:00','you''re'),
('2002-08-05',-1372061696,-1309081600,'you','HZDMV','kxrehdokus',34,'2006-09-23 10:32:20','is'),
('2007-04-02',-943128576,6,'all','rehdokusnvnyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtkn','hdokusnvny',35,'2009-05-25 13:58:06','l'),
('2002-02-13',313131008,2,'in','m','okusnvnyzn',36,'2006-08-12 00:00:00','j'),
('2003-12-27',1738670080,0,'have','it''s','JONLJ',37,'2007-07-16 16:16:00','your'),
('2004-12-08',521076736,8,'in','I''m','JMWAA',38,'0000-00-00 00:00:00','how'),
('2008-11-19',-1644494848,-825622528,'can''t','j','SBBFP',39,'2002-03-02 00:00:00','right'),
('0000-00-00',-1550581760,-2100101120,'YWBGX','y','EPZBT',40,'2009-10-26 05:31:43','nyznmwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqent'),
('0000-00-00',1,478740480,'you''re','mwcpfrhovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfb','n',41,'0000-00-00 00:00:00','i'),
('2000-06-07',5,4,'DMFMK','it','UMXZA',42,'0000-00-00 00:00:00','k'),
('0000-00-00',9,1455161344,'h','say','RWBQE',43,'2000-09-01 08:07:23','be'),
('2005-06-25',715128832,8,'q','he''s','NKMXB',44,'2005-06-20 14:30:41','EKHEK'),
('2000-11-19',-405078016,-664272896,'right','will','you''re',45,'2009-12-04 19:09:44','hovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrb'),
('2000-08-21',884670464,0,'ovzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdw','vzslvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvy','zslvzwaurs',46,'0000-00-00 00:00:00','slvzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyig'),
('2001-11-12',-1336999936,9,'d','VWDHL','could',47,'2009-04-22 00:00:00','MCCTH'),
('0000-00-00',689438720,-1074200576,'q','c','HYYZE',48,'2005-08-05 00:00:00','a'),
('2007-08-17',6,4,'BNWRR','with','hey',49,'2003-06-23 00:00:00','x'),
('0000-00-00',6,-1129971712,'vzwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzp','can''t','a',50,'2003-04-14 00:00:00','SJXZY'),
('0000-00-00',1750269952,7,'g','in','think',51,'0000-00-00 00:00:00','what'),
('2001-09-24',9,1,'your','good','this',52,'2006-01-20 04:30:35','QJMRV'),
('2002-04-02',-1260322816,-825622528,'zwaursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpj','aursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxex','k',53,'2009-07-10 01:05:15','ORDGH'),
('0000-00-00',1,1036255232,'his','ursraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiaf','got',54,'0000-00-00 00:00:00','SRDJJ'),
('2006-08-17',-1473380352,-316014592,'QEGKS','sraiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpc','raiwqyrydj',55,'2005-08-13 00:00:00','she'),
('2000-11-07',6,2,'aiwqyrydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceq','been','OWASJ',56,'2003-09-25 20:08:11','TZEJU'),
('2001-03-04',7,-370999296,'p','ZMEEY','his',57,'2005-05-15 19:44:38','o'),
('2000-01-11',-1763377152,6,'RHIXV','VZHEZ','ZFHOD',58,'2004-11-07 10:37:35','y'),
('2000-12-23',4,9,'k','ydjawfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypf','djawfmhsai',59,'2007-04-24 00:00:00','p'),
('2008-08-17',5,821624832,'v','awfmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnuds','wfmhsaiaoe',60,'2007-02-18 04:27:19','fmhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrr'),
('2005-08-15',1,52953088,'FDSZZ','KEVUE','because',61,'0000-00-00 00:00:00','mhsaiaoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrh'),
('0000-00-00',0,1,'can','BRHTF','he',62,'0000-00-00 00:00:00','UGFPP'),
('2008-01-13',48955392,-304939008,'GCUTY','g','could',63,'2002-12-03 00:00:00','PXQFO'),
('2005-07-11',5,8,'z','EHOWZ','WCIVZ',64,'0000-00-00 00:00:00','aoetpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloa'),
('2009-08-08',-1010368512,7,'PSYKF','etpunckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavd','tpunckiavn',65,'2008-03-28 00:00:00','m'),
('2002-04-15',854327296,723058688,'YFBXQ','with','s',66,'2008-07-10 00:00:00','want'),
('2004-10-13',6,-1585643520,'unckiavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhf','NGLFR','nckiavnezk',67,'2002-06-10 00:00:00','think'),
('0000-00-00',1255604224,0,'who','i','s',68,'0000-00-00 00:00:00','KVHOH'),
('2001-05-27',6,578945024,'j','CIEGM','q',69,'2008-06-23 12:54:40','k'),
('2008-06-22',7,7,'I''ll','PMPVX','TTXJR',70,'2009-12-23 18:33:10','not'),
('2009-09-09',7,2050949120,'want','iavnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyo','avnezkhtdz',71,'2004-07-15 14:40:26','a'),
('0000-00-00',654114816,-91095040,'LKBCZ','vnezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyoop','did',72,'0000-00-00 00:00:00','I''m'),
('2005-06-06',7,1341718528,'ezkhtdzkoyijcnkyzxactqjtndhmuuosalokrlw','c','a',73,'2006-05-24 00:00:00','then'),
('0000-00-00',-594870272,-136511488,'zkhtdzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaz','have','but',74,'2004-05-02 14:34:59','j'),
('2009-02-09',-1685520384,0,'u','c','my',75,'0000-00-00 00:00:00','oh'),
('2001-10-27',-2046361600,68026368,'l','and','OFMDP',76,'2005-11-03 22:02:41','EKORQ'),
('2004-08-15',7,1605894144,'what','dzkoyijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqst','good',77,'2002-05-13 00:00:00','m'),
('0000-00-00',4,9,'t','b','oyijcnkyzx',78,'2007-01-03 00:00:00','q'),
('0000-00-00',1637285888,1,'o','at','LAWNC',79,'2009-10-18 22:02:47','ijcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbm'),
('2006-04-04',0,1752694784,'JHHSM','jcnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmv','BNUQP',80,'2005-09-17 14:05:02','cnkyzxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvv'),
('2002-06-03',-48824320,-1086455808,'JXSHC','l','w',81,'0000-00-00 00:00:00','zxactqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfi'),
('0000-00-00',3,7,'q','actqjtndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrig','MEYYL',82,'2000-05-21 23:29:21','with'),
('2005-02-08',1144717312,-178061312,'q','b','t',83,'2009-11-07 04:32:24','BMKGH'),
('2007-05-14',-1435893760,-1779957760,'hey','j','qjtndhmuuo',84,'0000-00-00 00:00:00','AULUQ'),
('0000-00-00',4,0,'SMSJF','AXNRG','w',85,'2002-11-02 00:00:00','ndhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuro'),
('2008-05-16',1,7405568,'CFZIC','dhmuuosalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroq','a',86,'2002-12-02 19:23:24','in'),
('2000-06-12',8,-964689920,'BCRSP','muuosalokrlwnklvxgaenmqsbhvjljjtwih','YFICI',87,'0000-00-00 00:00:00','j'),
('0000-00-00',8,1,'z','something','WGQTU',88,'2008-11-09 21:30:47','v'),
('2005-12-22',3,-1223229440,'up','EUUXE','y',89,'0000-00-00 00:00:00','osalokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroqobuli'),
('2003-10-14',-1609367552,5,'mean','it''s','about',90,'0000-00-00 00:00:00','salokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhn'),
('0000-00-00',-1540161536,3,'CXNSI','alokrlwnklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroqobulicy','k',91,'0000-00-00 00:00:00','ZPLSW'),
('2009-08-22',-141819904,41484288,'be','DNQON','what',92,'2004-10-12 00:00:00','come'),
('2002-12-13',5,8,'v','oh','ZTLEX',93,'0000-00-00 00:00:00','HZFDL'),
('2009-06-02',8,1,'CAPTP','GINNV','m',94,'2004-03-21 00:00:00','VWCPD'),
('2006-02-22',-709689344,9,'p','nklvxgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroqobulicytmhdkim','it''s',95,'0000-00-00 00:00:00','e'),
('2000-10-20',4,9,'KSCQW','on','vxgaenmqsb',96,'0000-00-00 00:00:00','xgaenmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroqobulicytmhdkimtobx'),
('2001-02-17',1506213888,2,'c','i','aenmqsbhvj',97,'2007-11-07 00:37:50','enmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroqobulicytmhdkimtobxgsn'),
('2004-05-24',-429326336,-1471217664,'KFZZJ','nmqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroqobulicytmhdkimtobxgsny','this',98,'2001-08-21 00:00:00','mqsbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroqobulicytmhdkimtobxgsnys'),
('2002-05-04',-1328480256,-921436160,'u','sbhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroqobulicytmhdkimtobxgsnyszv','WMVOZ',99,'0000-00-00 00:00:00','bhvjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyooplaznqstonlbmvvxqbrigiqwuroqobulicytmhdkimtobxgsnyszvw'),
('2002-06-26',-49479680,1015218176,'vjljjtwihdwnbqvjrmtpofgxyfyzjwfibgnvbnevnrpyfaneytpmhncxxghvypfxqrsanxuhqdbwsnqixqbbfivfthgxpiplocnswqbywqalcwwypgdbwrxexdkppzzrzmiacfjtknpaqsneqentgmfbezxfrbvyigzpjiafpceqfuryhnudsrrhoaloavdmhfpwyoo','yes','KSKBQ',100,'2001-07-17 00:00:00','with');

SET @@SESSION.sort_buffer_size=32768;

SELECT
table3 . `col_varchar_255_utf8_key` AS field1 ,
table2 . `col_varchar_255_latin1_key` AS field3 ,
table3 . `col_varchar_255_latin1` AS field4 ,
JSON_EXTRACT(JSON_ARRAY(table3. `col_date_key`), CONCAT('$[',0,']' )) AS field5
FROM  H AS table1
LEFT JOIN  H AS table2
LEFT OUTER JOIN F AS table3
ON  table2 . `pk` <  table3 . `col_int_key`
ON  table1 . `pk` =  table3 . `pk`
WHERE    table1.`col_varchar_255_utf8_key` >= table3.`col_varchar_10_utf8`
GROUP BY
field1, field3, field4, field5;
SET @@SESSION.sort_buffer_size=default;

DROP TABLE F, H;

-- Verify that JSON columns, despite being blobs, are not sorted by row ID.

CREATE TABLE t1 (
  pk INTEGER,
  j JSON
);

DROP TABLE t1;
