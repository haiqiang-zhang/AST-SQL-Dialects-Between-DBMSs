DROP TABLE IF EXISTS t1, `"t"1`, t1aa, t2, t2aa, t3;
drop database if exists mysqldump_test_db;
drop database if exists db1;
drop database if exists db2;
drop view if exists v1, v2, v3;
CREATE TABLE t1(a INT, KEY (a)) ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=1 ENGINE=Innodb;
INSERT INTO t1 VALUES (1), (2);
DROP TABLE t1;
CREATE TABLE t1 (a decimal(64, 20));
INSERT INTO t1 VALUES ("1234567890123456789012345678901234567890"),
("0987654321098765432109876543210987654321");
DROP TABLE t1;
CREATE TABLE t1 (a double);
INSERT IGNORE INTO t1 VALUES ('-9e999999');
DROP TABLE t1;
CREATE TABLE t1 (a DECIMAL(10,5), b FLOAT);
INSERT INTO t1 VALUES (1.2345, 2.3456);
INSERT INTO t1 VALUES ('1.2345', 2.3456);
INSERT INTO t1 VALUES ("1.2345", 2.3456);
INSERT INTO t1 VALUES (1.2345, 2.3456);
INSERT INTO t1 VALUES ('1.2345', 2.3456);
INSERT INTO t1 VALUES ("1.2345", 2.3456);
DROP TABLE t1;
CREATE TABLE t1(a int, b text, c varchar(3));
INSERT INTO t1 VALUES (1, "test", "tes"), (2, "TEST", "TES");
DROP TABLE t1;
CREATE TABLE t1 (`a"b"` char(2));
INSERT INTO t1 VALUES ("1\""), ("\"2");
DROP TABLE t1;
CREATE TABLE t1 (a  VARCHAR(255)) DEFAULT CHARSET koi8r;
INSERT INTO t1  VALUES (_koi8r x'C1C2C3C4C5'), (NULL);
DROP TABLE t1;
create table ```a` (i int);
drop table ```a`;
create table t1(a int);
drop table t1;
create table t1(a int);
insert into t1 values (1),(2),(3);
drop table t1;
create database mysqldump_test_db character set latin2 collate latin2_bin;
drop database mysqldump_test_db;
CREATE TABLE t1 (a  CHAR(10));
INSERT INTO t1  VALUES (_latin1 x'C4D6DCDF');
DROP TABLE t1;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (a int);
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (4),(5),(6);
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (`b` blob);
INSERT INTO `t1` VALUES (0x602010000280100005E71A);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t1 VALUES (4),(5),(6);
DROP TABLE t1;
create table t1 (
 F_c4ca4238a0b923820dcc509a6f75849b int,
 F_c81e728d9d4c2f636f067f89cc14862c int,
 F_eccbc87e4b5ce2fe28308fd9f2a7baf3 int,
 F_a87ff679a2f3e71d9181a67b7542122c int,
 F_e4da3b7fbbce2345d7772b0674a318d5 int,
 F_1679091c5a880faf6fb5e6087eb1b2dc int,
 F_8f14e45fceea167a5a36dedd4bea2543 int,
 F_c9f0f895fb98ab9159f51fd0297e236d int,
 F_45c48cce2e2d7fbdea1afc51c7c6ad26 int,
 F_d3d9446802a44259755d38e6d163e820 int,
 F_6512bd43d9caa6e02c990b0a82652dca int,
 F_c20ad4d76fe97759aa27a0c99bff6710 int,
 F_c51ce410c124a10e0db5e4b97fc2af39 int,
 F_aab3238922bcc25a6f606eb525ffdc56 int,
 F_9bf31c7ff062936a96d3c8bd1f8f2ff3 int,
 F_c74d97b01eae257e44aa9d5bade97baf int,
 F_70efdf2ec9b086079795c442636b55fb int,
 F_6f4922f45568161a8cdf4ad2299f6d23 int,
 F_1f0e3dad99908345f7439f8ffabdffc4 int,
 F_98f13708210194c475687be6106a3b84 int,
 F_3c59dc048e8850243be8079a5c74d079 int,
 F_b6d767d2f8ed5d21a44b0e5886680cb9 int,
 F_37693cfc748049e45d87b8c7d8b9aacd int,
 F_1ff1de774005f8da13f42943881c655f int,
 F_8e296a067a37563370ded05f5a3bf3ec int,
 F_4e732ced3463d06de0ca9a15b6153677 int,
 F_02e74f10e0327ad868d138f2b4fdd6f0 int,
 F_33e75ff09dd601bbe69f351039152189 int,
 F_6ea9ab1baa0efb9e19094440c317e21b int,
 F_34173cb38f07f89ddbebc2ac9128303f int,
 F_c16a5320fa475530d9583c34fd356ef5 int,
 F_6364d3f0f495b6ab9dcf8d3b5c6e0b01 int,
 F_182be0c5cdcd5072bb1864cdee4d3d6e int,
 F_e369853df766fa44e1ed0ff613f563bd int,
 F_1c383cd30b7c298ab50293adfecb7b18 int,
 F_19ca14e7ea6328a42e0eb13d585e4c22 int,
 F_a5bfc9e07964f8dddeb95fc584cd965d int,
 F_a5771bce93e200c36f7cd9dfd0e5deaa int,
 F_d67d8ab4f4c10bf22aa353e27879133c int,
 F_d645920e395fedad7bbbed0eca3fe2e0 int,
 F_3416a75f4cea9109507cacd8e2f2aefc int,
 F_a1d0c6e83f027327d8461063f4ac58a6 int,
 F_17e62166fc8586dfa4d1bc0e1742c08b int,
 F_f7177163c833dff4b38fc8d2872f1ec6 int,
 F_6c8349cc7260ae62e3b1396831a8398f int,
 F_d9d4f495e875a2e075a1a4a6e1b9770f int,
 F_67c6a1e7ce56d3d6fa748ab6d9af3fd7 int,
 F_642e92efb79421734881b53e1e1b18b6 int,
 F_f457c545a9ded88f18ecee47145a72c0 int,
 F_c0c7c76d30bd3dcaefc96f40275bdc0a int,
 F_2838023a778dfaecdc212708f721b788 int,
 F_9a1158154dfa42caddbd0694a4e9bdc8 int,
 F_d82c8d1619ad8176d665453cfb2e55f0 int,
 F_a684eceee76fc522773286a895bc8436 int,
 F_b53b3a3d6ab90ce0268229151c9bde11 int,
 F_9f61408e3afb633e50cdf1b20de6f466 int,
 F_72b32a1f754ba1c09b3695e0cb6cde7f int,
 F_66f041e16a60928b05a7e228a89c3799 int,
 F_093f65e080a295f8076b1c5722a46aa2 int,
 F_072b030ba126b2f4b2374f342be9ed44 int,
 F_7f39f8317fbdb1988ef4c628eba02591 int,
 F_44f683a84163b3523afe57c2e008bc8c int,
 F_03afdbd66e7929b125f8597834fa83a4 int,
 F_ea5d2f1c4608232e07d3aa3d998e5135 int,
 F_fc490ca45c00b1249bbe3554a4fdf6fb int,
 F_3295c76acbf4caaed33c36b1b5fc2cb1 int,
 F_735b90b4568125ed6c3f678819b6e058 int,
 F_a3f390d88e4c41f2747bfa2f1b5f87db int,
 F_14bfa6bb14875e45bba028a21ed38046 int,
 F_7cbbc409ec990f19c78c75bd1e06f215 int,
 F_e2c420d928d4bf8ce0ff2ec19b371514 int,
 F_32bb90e8976aab5298d5da10fe66f21d int,
 F_d2ddea18f00665ce8623e36bd4e3c7c5 int,
 F_ad61ab143223efbc24c7d2583be69251 int,
 F_d09bf41544a3365a46c9077ebb5e35c3 int,
 F_fbd7939d674997cdb4692d34de8633c4 int,
 F_28dd2c7955ce926456240b2ff0100bde int,
 F_35f4a8d465e6e1edc05f3d8ab658c551 int,
 F_d1fe173d08e959397adf34b1d77e88d7 int,
 F_f033ab37c30201f73f142449d037028d int,
 F_43ec517d68b6edd3015b3edc9a11367b int,
 F_9778d5d219c5080b9a6a17bef029331c int,
 F_fe9fc289c3ff0af142b6d3bead98a923 int,
 F_68d30a9594728bc39aa24be94b319d21 int,
 F_3ef815416f775098fe977004015c6193 int,
 F_93db85ed909c13838ff95ccfa94cebd9 int,
 F_c7e1249ffc03eb9ded908c236bd1996d int,
 F_2a38a4a9316c49e5a833517c45d31070 int,
 F_7647966b7343c29048673252e490f736 int,
 F_8613985ec49eb8f757ae6439e879bb2a int,
 F_54229abfcfa5649e7003b83dd4755294 int,
 F_92cc227532d17e56e07902b254dfad10 int,
 F_98dce83da57b0395e163467c9dae521b int,
 F_f4b9ec30ad9f68f89b29639786cb62ef int,
 F_812b4ba287f5ee0bc9d43bbf5bbe87fb int,
 F_26657d5ff9020d2abefe558796b99584 int,
 F_e2ef524fbf3d9fe611d5a8e90fefdc9c int,
 F_ed3d2c21991e3bef5e069713af9fa6ca int,
 F_ac627ab1ccbdb62ec96e702f07f6425b int,
 F_f899139df5e1059396431415e770c6dd int,
 F_38b3eff8baf56627478ec76a704e9b52 int,
 F_ec8956637a99787bd197eacd77acce5e int,
 F_6974ce5ac660610b44d9b9fed0ff9548 int,
 F_c9e1074f5b3f9fc8ea15d152add07294 int,
 F_65b9eea6e1cc6bb9f0cd2a47751a186f int,
 F_f0935e4cd5920aa6c7c996a5ee53a70f int,
 F_a97da629b098b75c294dffdc3e463904 int,
 F_a3c65c2974270fd093ee8a9bf8ae7d0b int,
 F_2723d092b63885e0d7c260cc007e8b9d int,
 F_5f93f983524def3dca464469d2cf9f3e int,
 F_698d51a19d8a121ce581499d7b701668 int,
 F_7f6ffaa6bb0b408017b62254211691b5 int,
 F_73278a4a86960eeb576a8fd4c9ec6997 int,
 F_5fd0b37cd7dbbb00f97ba6ce92bf5add int,
 F_2b44928ae11fb9384c4cf38708677c48 int,
 F_c45147dee729311ef5b5c3003946c48f int,
 F_eb160de1de89d9058fcb0b968dbbbd68 int,
 F_5ef059938ba799aaa845e1c2e8a762bd int,
 F_07e1cd7dca89a1678042477183b7ac3f int,
 F_da4fb5c6e93e74d3df8527599fa62642 int,
 F_4c56ff4ce4aaf9573aa5dff913df997a int,
 F_a0a080f42e6f13b3a2df133f073095dd int,
 F_202cb962ac59075b964b07152d234b70 int,
 F_c8ffe9a587b126f152ed3d89a146b445 int,
 F_3def184ad8f4755ff269862ea77393dd int,
 F_069059b7ef840f0c74a814ec9237b6ec int,
 F_ec5decca5ed3d6b8079e2e7e7bacc9f2 int,
 F_76dc611d6ebaafc66cc0879c71b5db5c int,
 F_d1f491a404d6854880943e5c3cd9ca25 int,
 F_9b8619251a19057cff70779273e95aa6 int,
 F_1afa34a7f984eeabdbb0a7d494132ee5 int,
 F_65ded5353c5ee48d0b7d48c591b8f430 int,
 F_9fc3d7152ba9336a670e36d0ed79bc43 int,
 F_02522a2b2726fb0a03bb19f2d8d9524d int,
 F_7f1de29e6da19d22b51c68001e7e0e54 int,
 F_42a0e188f5033bc65bf8d78622277c4e int,
 F_3988c7f88ebcb58c6ce932b957b6f332 int,
 F_013d407166ec4fa56eb1e1f8cbe183b9 int,
 F_e00da03b685a0dd18fb6a08af0923de0 int,
 F_1385974ed5904a438616ff7bdb3f7439 int,
 F_0f28b5d49b3020afeecd95b4009adf4c int,
 F_a8baa56554f96369ab93e4f3bb068c22 int,
 F_903ce9225fca3e988c2af215d4e544d3 int,
 F_0a09c8844ba8f0936c20bd791130d6b6 int,
 F_2b24d495052a8ce66358eb576b8912c8 int,
 F_a5e00132373a7031000fd987a3c9f87b int,
 F_8d5e957f297893487bd98fa830fa6413 int,
 F_47d1e990583c9c67424d369f3414728e int,
 F_f2217062e9a397a1dca429e7d70bc6ca int,
 F_7ef605fc8dba5425d6965fbd4c8fbe1f int,
 F_a8f15eda80c50adb0e71943adc8015cf int,
 F_37a749d808e46495a8da1e5352d03cae int,
 F_b3e3e393c77e35a4a3f3cbd1e429b5dc int,
 F_1d7f7abc18fcb43975065399b0d1e48e int,
 F_2a79ea27c279e471f4d180b08d62b00a int,
 F_1c9ac0159c94d8d0cbedc973445af2da int,
 F_6c4b761a28b734fe93831e3fb400ce87 int,
 F_06409663226af2f3114485aa4e0a23b4 int,
 F_140f6969d5213fd0ece03148e62e461e int,
 F_b73ce398c39f506af761d2277d853a92 int,
 F_bd4c9ab730f5513206b999ec0d90d1fb int,
 F_82aa4b0af34c2313a562076992e50aa3 int,
 F_0777d5c17d4066b82ab86dff8a46af6f int,
 F_fa7cdfad1a5aaf8370ebeda47a1ff1c3 int,
 F_9766527f2b5d3e95d4a733fcfb77bd7e int,
 F_7e7757b1e12abcb736ab9a754ffb617a int,
 F_5878a7ab84fb43402106c575658472fa int,
 F_006f52e9102a8d3be2fe5614f42ba989 int,
 F_3636638817772e42b59d74cff571fbb3 int,
 F_149e9677a5989fd342ae44213df68868 int,
 F_a4a042cf4fd6bfb47701cbc8a1653ada int,
 F_1ff8a7b5dc7a7d1f0ed65aaa29c04b1e int,
 F_f7e6c85504ce6e82442c770f7c8606f0 int,
 F_bf8229696f7a3bb4700cfddef19fa23f int,
 F_82161242827b703e6acf9c726942a1e4 int,
 F_38af86134b65d0f10fe33d30dd76442e int,
 F_96da2f590cd7246bbde0051047b0d6f7 int,
 F_8f85517967795eeef66c225f7883bdcb int,
 F_8f53295a73878494e9bc8dd6c3c7104f int,
 F_045117b0e0a11a242b9765e79cbf113f int,
 F_fc221309746013ac554571fbd180e1c8 int,
 F_4c5bde74a8f110656874902f07378009 int,
 F_cedebb6e872f539bef8c3f919874e9d7 int,
 F_6cdd60ea0045eb7a6ec44c54d29ed402 int,
 F_eecca5b6365d9607ee5a9d336962c534 int,
 F_9872ed9fc22fc182d371c3e9ed316094 int,
 F_31fefc0e570cb3860f2a6d4b38c6490d int,
 F_9dcb88e0137649590b755372b040afad int,
 F_a2557a7b2e94197ff767970b67041697 int,
 F_cfecdb276f634854f3ef915e2e980c31 int,
 F_0aa1883c6411f7873cb83dacb17b0afc int,
 F_58a2fc6ed39fd083f55d4182bf88826d int,
 F_bd686fd640be98efaae0091fa301e613 int,
 F_a597e50502f5ff68e3e25b9114205d4a int,
 F_0336dcbab05b9d5ad24f4333c7658a0e int,
 F_084b6fbb10729ed4da8c3d3f5a3ae7c9 int,
 F_85d8ce590ad8981ca2c8286f79f59954 int,
 F_0e65972dce68dad4d52d063967f0a705 int,
 F_84d9ee44e457ddef7f2c4f25dc8fa865 int,
 F_3644a684f98ea8fe223c713b77189a77 int,
 F_757b505cfd34c64c85ca5b5690ee5293 int,
 F_854d6fae5ee42911677c739ee1734486 int,
 F_e2c0be24560d78c5e599c2a9c9d0bbd2 int,
 F_274ad4786c3abca69fa097b85867d9a4 int,
 F_eae27d77ca20db309e056e3d2dcd7d69 int,
 F_7eabe3a1649ffa2b3ff8c02ebfd5659f int,
 F_69adc1e107f7f7d035d7baf04342e1ca int,
 F_091d584fced301b442654dd8c23b3fc9 int,
 F_b1d10e7bafa4421218a51b1e1f1b0ba2 int,
 F_6f3ef77ac0e3619e98159e9b6febf557 int,
 F_eb163727917cbba1eea208541a643e74 int,
 F_1534b76d325a8f591b52d302e7181331 int,
 F_979d472a84804b9f647bc185a877a8b5 int,
 F_ca46c1b9512a7a8315fa3c5a946e8265 int,
 F_3b8a614226a953a8cd9526fca6fe9ba5 int,
 F_45fbc6d3e05ebd93369ce542e8f2322d int,
 F_63dc7ed1010d3c3b8269faf0ba7491d4 int,
 F_e96ed478dab8595a7dbda4cbcbee168f int,
 F_c0e190d8267e36708f955d7ab048990d int,
 F_ec8ce6abb3e952a85b8551ba726a1227 int,
 F_060ad92489947d410d897474079c1477 int,
 F_bcbe3365e6ac95ea2c0343a2395834dd int,
 F_115f89503138416a242f40fb7d7f338e int,
 F_13fe9d84310e77f13a6d184dbf1232f3 int,
 F_d1c38a09acc34845c6be3a127a5aacaf int,
 F_9cfdf10e8fc047a44b08ed031e1f0ed1 int,
 F_705f2172834666788607efbfca35afb3 int,
 F_74db120f0a8e5646ef5a30154e9f6deb int,
 F_57aeee35c98205091e18d1140e9f38cf int,
 F_6da9003b743b65f4c0ccd295cc484e57 int,
 F_9b04d152845ec0a378394003c96da594 int,
 F_be83ab3ecd0db773eb2dc1b0a17836a1 int,
 F_e165421110ba03099a1c0393373c5b43 int,
 F_289dff07669d7a23de0ef88d2f7129e7 int,
 F_577ef1154f3240ad5b9b413aa7346a1e int,
 F_01161aaa0b6d1345dd8fe4e481144d84 int,
 F_539fd53b59e3bb12d203f45a912eeaf2 int,
 F_ac1dd209cbcc5e5d1c6e28598e8cbbe8 int,
 F_555d6702c950ecb729a966504af0a635 int,
 F_335f5352088d7d9bf74191e006d8e24c int,
 F_f340f1b1f65b6df5b5e3f94d95b11daf int,
 F_e4a6222cdb5b34375400904f03d8e6a5 int,
 F_cb70ab375662576bd1ac5aaf16b3fca4 int,
 F_9188905e74c28e489b44e954ec0b9bca int,
 F_0266e33d3f546cb5436a10798e657d97 int,
 F_38db3aed920cf82ab059bfccbd02be6a int,
 F_3cec07e9ba5f5bb252d13f5f431e4bbb int,
 F_621bf66ddb7c962aa0d22ac97d69b793 int,
 F_077e29b11be80ab57e1a2ecabb7da330 int,
 F_6c9882bbac1c7093bd25041881277658 int,
 F_19f3cd308f1455b3fa09a282e0d496f4 int,
 F_03c6b06952c750899bb03d998e631860 int,
 F_c24cd76e1ce41366a4bbe8a49b02a028 int,
 F_c52f1bd66cc19d05628bd8bf27af3ad6 int,
 F_fe131d7f5a6b38b23cc967316c13dae2 int,
 F_f718499c1c8cef6730f9fd03c8125cab int,
 F_d96409bf894217686ba124d7356686c9 int,
 F_502e4a16930e414107ee22b6198c578f int,
 F_cfa0860e83a4c3a763a7e62d825349f7 int,
 F_a4f23670e1833f3fdb077ca70bbd5d66 int,
 F_b1a59b315fc9a3002ce38bbe070ec3f5 int,
 F_36660e59856b4de58a219bcf4e27eba3 int,
 F_8c19f571e251e61cb8dd3612f26d5ecf int,
 F_d6baf65e0b240ce177cf70da146c8dc8 int,
 F_e56954b4f6347e897f954495eab16a88 int,
 F_f7664060cc52bc6f3d620bcedc94a4b6 int,
 F_eda80a3d5b344bc40f3bc04f65b7a357 int,
 F_8f121ce07d74717e0b1f21d122e04521 int,
 F_06138bc5af6023646ede0e1f7c1eac75 int,
 F_39059724f73a9969845dfe4146c5660e int,
 F_7f100b7b36092fb9b06dfb4fac360931 int,
 F_7a614fd06c325499f1680b9896beedeb int,
 F_4734ba6f3de83d861c3176a6273cac6d int,
 F_d947bf06a885db0d477d707121934ff8 int,
 F_63923f49e5241343aa7acb6a06a751e7 int,
 F_db8e1af0cb3aca1ae2d0018624204529 int,
 F_20f07591c6fcb220ffe637cda29bb3f6 int,
 F_07cdfd23373b17c6b337251c22b7ea57 int,
 F_d395771085aab05244a4fb8fd91bf4ee int,
 F_92c8c96e4c37100777c7190b76d28233 int,
 F_e3796ae838835da0b6f6ea37bcf8bcb7 int,
 F_6a9aeddfc689c1d0e3b9ccc3ab651bc5 int,
 F_0f49c89d1e7298bb9930789c8ed59d48 int,
 F_46ba9f2a6976570b0353203ec4474217 int,
 F_0e01938fc48a2cfb5f2217fbfb00722d int,
 F_16a5cdae362b8d27a1d8f8c7b78b4330 int,
 F_918317b57931b6b7a7d29490fe5ec9f9 int,
 F_48aedb8880cab8c45637abc7493ecddd int,
 F_839ab46820b524afda05122893c2fe8e int,
 F_f90f2aca5c640289d0a29417bcb63a37 int,
 F_9c838d2e45b2ad1094d42f4ef36764f6 int,
 F_1700002963a49da13542e0726b7bb758 int,
 F_53c3bce66e43be4f209556518c2fcb54 int,
 F_6883966fd8f918a4aa29be29d2c386fb int,
 F_49182f81e6a13cf5eaa496d51fea6406 int,
 F_d296c101daa88a51f6ca8cfc1ac79b50 int,
 F_9fd81843ad7f202f26c1a174c7357585 int,
 F_26e359e83860db1d11b6acca57d8ea88 int,
 F_ef0d3930a7b6c95bd2b32ed45989c61f int,
 F_94f6d7e04a4d452035300f18b984988c int,
 F_34ed066df378efacc9b924ec161e7639 int,
 F_577bcc914f9e55d5e4e4f82f9f00e7d4 int,
 F_11b9842e0a271ff252c1903e7132cd68 int,
 F_37bc2f75bf1bcfe8450a1a41c200364c int,
 F_496e05e1aea0a9c4655800e8a7b9ea28 int,
 F_b2eb7349035754953b57a32e2841bda5 int,
 F_8e98d81f8217304975ccb23337bb5761 int,
 F_a8c88a0055f636e4a163a5e3d16adab7 int,
 F_eddea82ad2755b24c4e168c5fc2ebd40 int,
 F_06eb61b839a0cefee4967c67ccb099dc int,
 F_9dfcd5e558dfa04aaf37f137a1d9d3e5 int,
 F_950a4152c2b4aa3ad78bdd6b366cc179 int,
 F_158f3069a435b314a80bdcb024f8e422 int,
 F_758874998f5bd0c393da094e1967a72b int,
 F_ad13a2a07ca4b7642959dc0c4c740ab6 int,
 F_3fe94a002317b5f9259f82690aeea4cd int,
 F_5b8add2a5d98b1a652ea7fd72d942dac int,
 F_432aca3a1e345e339f35a30c8f65edce int,
 F_8d3bba7425e7c98c50f52ca1b52d3735 int,
 F_320722549d1751cf3f247855f937b982 int,
 F_caf1a3dfb505ffed0d024130f58c5cfa int,
 F_5737c6ec2e0716f3d8a7a5c4e0de0d9a int,
 F_bc6dc48b743dc5d013b1abaebd2faed2 int,
 F_f2fc990265c712c49d51a18a32b39f0c int,
 F_89f0fd5c927d466d6ec9a21b9ac34ffa int,
 F_a666587afda6e89aec274a3657558a27 int,
 F_b83aac23b9528732c23cc7352950e880 int,
 F_cd00692c3bfe59267d5ecfac5310286c int,
 F_6faa8040da20ef399b63a72d0e4ab575 int,
 F_fe73f687e5bc5280214e0486b273a5f9 int);
insert into t1 (F_8d3bba7425e7c98c50f52ca1b52d3735) values (1);
drop table t1;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1),(2),(3);
DROP TABLE t1;
CREATE DATABASE mysqldump_test_db;
CREATE TABLE t1 ( a INT );
CREATE TABLE t2 ( a INT );
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1), (2);
DROP TABLE t1, t2;
DROP DATABASE mysqldump_test_db;
create database mysqldump_test_db;
create table t1(a varchar(30) primary key, b int not null);
create table t2(a varchar(30) primary key, b int not null);
create table t3(a varchar(30) primary key, b int not null);
select '------ Testing with illegal table names ------' as test_sequence;
select '------ Testing with illegal database names ------' as test_sequence;
drop table t1, t2, t3;
drop database mysqldump_test_db;
create table t1 (a int(10));
create table t2 (pk int primary key auto_increment,
a int(10), b varchar(30), c datetime, d blob, e text);
insert into t1 values (NULL), (10), (20);
insert into t2 (a, b) values (NULL, NULL),(10, NULL),(NULL, "twenty"),(30, "thirty");
drop table t1, t2;
create table t1 (a text character set utf8mb3, b text character set latin1);
insert t1 values (0x4F736E616272C3BC636B, 0x4BF66C6E);
select * from t1;
select * from t1;
drop table t1;
create table `t1` (
    t1_name varchar(255) default null,
    t1_id int(10) unsigned not null auto_increment,
    key (t1_name),
    primary key (t1_id)
) auto_increment = 1000 default charset=latin1;
insert into t1 (t1_name) values('bla');
insert into t1 (t1_name) values('bla');
insert into t1 (t1_name) values('bla');
select * from t1;
DROP TABLE `t1`;
create table t1(a int);
create table t2(a int);
create table t3(a int);
drop table t1, t2, t3;
create table t1 (a int);
drop table t1;
DROP TABLE IF EXISTS `t1`;
CREATE TABLE `t1` (
  `a b` INT,
  `c"d` INT,
  `e``f` INT,
  PRIMARY KEY (`a b`, `c"d`, `e``f`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
insert into t1 values (0815, 4711, 2006);
DROP TABLE `t1`;
create database db1;
CREATE TABLE t2 (
  a varchar(30) default NULL,
  KEY a (a(5))
);
INSERT INTO t2 VALUES ('alfred');
INSERT INTO t2 VALUES ('angie');
INSERT INTO t2 VALUES ('bingo');
INSERT INTO t2 VALUES ('waffle');
INSERT INTO t2 VALUES ('lemon');
create view v2 as select * from t2 where a like 'a%' with check option;
drop table t2;
drop view v2;
drop database db1;
create database db2;
create table t1 (a int);
create table t2 (a int, b varchar(10), primary key(a));
insert into t2 values (1, "on"), (2, "off"), (10, "pol"), (12, "meg");
insert into t1 values (289), (298), (234), (456), (789);
create view v1 as select * from t2;
create view v2 as select * from t1;
drop table t1, t2;
drop view v1, v2;
drop database db2;
create database db1;
drop database db1;
create table t1(a int, b int);
create view v1 as select * from t1;
create view v2 (c, d) as select * from t1;
drop view v1, v2;
drop table t1;
create database mysqldump_test_db;
CREATE TABLE t2 (
  a varchar(30) default NULL,
  KEY a (a(5))
);
INSERT INTO t2 VALUES ('alfred');
INSERT INTO t2 VALUES ('angie');
INSERT INTO t2 VALUES ('bingo');
INSERT INTO t2 VALUES ('waffle');
INSERT INTO t2 VALUES ('lemon');
create view v2 as select * from t2 where a like 'a%' with check option;
drop table t2;
drop view v2;
drop database mysqldump_test_db;
CREATE TABLE t1 (a char(10));
INSERT INTO t1 VALUES ('\'');
DROP TABLE t1;
create table t1(a int, b int, c varchar(30));
insert into t1 values(1, 2, "one"), (2, 4, "two"), (3, 6, "three");
create view v3 as
select * from t1;
create  view v1 as
select * from v3 where b in (1, 2, 3, 4, 5, 6, 7);
create  view v2 as
select v3.a from v3, v1 where v1.a=v3.a and v3.b=3 limit 1;
drop view v1, v2, v3;
drop table t1;
CREATE TABLE t1 (a int, b bigint default NULL);
CREATE TABLE t2 (a int);
INSERT INTO t1 (a) VALUES (1),(2),(3),(22);
update t1 set a = 4 where a=3;
drop table t1;
DROP TABLE IF EXISTS `test1`;
CREATE TABLE `test1` (
  `a1` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
DROP TABLE IF EXISTS `test2`;
CREATE TABLE `test2` (
  `a2` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `test1` VALUES (1);
SELECT * FROM `test2`;
SELECT * FROM `test1`;
SELECT * FROM `test2`;
DROP TABLE test1;
DROP TABLE test2;
DROP TABLE IF EXISTS t1;
DROP FUNCTION IF EXISTS bug9056_func1;
DROP FUNCTION IF EXISTS bug9056_func2;
DROP PROCEDURE IF EXISTS bug9056_proc1;
DROP PROCEDURE IF EXISTS bug9056_proc2;
DROP PROCEDURE IF EXISTS `a'b`;
CREATE TABLE t1 (id int);
INSERT INTO t1 VALUES(1), (2), (3), (4), (5);
create procedure `a'b` () select 1;
DROP PROCEDURE `a'b`;
drop table t1;
drop table if exists t1;
create table t1 (`d` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, unique (`d`));
insert into t1 values ('2003-10-25 22:00:00'),('2003-10-25 23:00:00');
select * from t1;
select * from t1;
drop table t1;
DROP TABLE IF EXISTS `t1 test`;
DROP TABLE IF EXISTS `t2 test`;
CREATE TABLE `t1 test` (
  `a1` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
CREATE TABLE `t2 test` (
  `a2` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `t1 test` VALUES (1);
INSERT INTO `t1 test` VALUES (2);
INSERT INTO `t1 test` VALUES (3);
SELECT * FROM `t2 test`;
DROP TABLE `t1 test`;
DROP TABLE `t2 test`;
drop table if exists t1;
create table t1 (a int, b varchar(32), c varchar(32));
insert into t1 values (1, 'first value', 'xxxx');
insert into t1 values (2, 'second value', 'tttt');
insert into t1 values (3, 'third value', 'vvv vvv');
create view v1 as select * from t1;
create view v0 as select * from v1;
create view v2 as select * from v0;
select * from v2;
drop view v2;
drop view v0;
drop view v1;
drop table t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
create table t1 (a binary(1), b blob);
insert into t1 values ('','');
drop table t1;
create table t1 (a int);
insert into t1 values (289), (298), (234), (456), (789);
create definer = CURRENT_USER view v1 as select * from t1;
create SQL SECURITY INVOKER view v2 as select * from t1;
create view v3 as select * from t1 with local check option;
create algorithm=merge view v4 as select * from t1 with cascaded check option;
create algorithm =temptable view v5 as select * from t1;
drop table t1;
drop view v1, v2, v3, v4, v5;
create table t1 (a int, created datetime);
drop table t1, t2;
create table t (qty int, price int);
insert into t values(3, 50);
insert into t values(5, 51);
create view v1 as select qty, price, qty*price as value from t;
create view v2 as select qty from v1;
drop view v1;
drop view v2;
drop table t;
create table t1 ( id serial );
create view v1 as select * from t1;
drop table t1;
drop view v1;
create database mysqldump_test_db;
create table t1 (id int);
create view v1 as select * from t1;
insert into t1 values (1232131);
insert into t1 values (4711);
insert into t1 values (3231);
insert into t1 values (0815);
drop view v1;
drop table t1;
drop database mysqldump_test_db;
create database mysqldump_tables;
create table basetable ( id serial, tag varchar(64) );
create database mysqldump_views;
drop database mysqldump_views;
drop database mysqldump_tables;
create database mysqldump_dba;
create table t1 (f1 int, f2 int);
insert into t1 values (1,1);
create view v1 as select f1, f2 from t1;
create database mysqldump_dbb;
insert into t1 values (2,2);
drop view v1;
drop table t1;
drop database mysqldump_dbb;
drop database mysqldump_dba;
create table t1(a int, b varchar(34));
drop table t1;
create database mysqldump_myDB;
create table t1 (c1 int);
insert into t1 values (3);
create table u1 (f1 int);
insert into u1 values (4);
create view v1 (c1) as select * from t1;
drop view v1;
drop table t1;
drop table u1;
drop database mysqldump_myDB;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (f1 int(10), data MEDIUMBLOB);
INSERT INTO t1 VALUES(1, 0xff00fef0);
DROP TABLE t1;
CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (1), (2);
DROP TABLE t1;
CREATE TABLE t2 (a INT) ENGINE=MYISAM;
CREATE TABLE t3 (a INT) ENGINE=MYISAM;
CREATE TABLE t1 (a INT) ENGINE=merge UNION=(t2, t3);
DROP TABLE t1, t2, t3;
create database bug23491_original;
create database bug23491_restore;
create table t1 (c1 int);
create view v1 as select * from t1;
create procedure p1() select 1;
drop database bug23491_original;
drop database bug23491_restore;
create database mysqldump_test_db;
drop database mysqldump_test_db;
DROP TABLE t1;
DROP VIEW v1;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c1 INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
SELECT * FROM t2;
SELECT * FROM t2;
DROP TABLE t1,t2;
create database db42635;
create table t1 (id int);
drop database db42635;
drop table if exists t1;
CREATE TABLE t1(a int, b int);
INSERT INTO t1 VALUES (1,1);
INSERT INTO t1 VALUES (2,3);
INSERT INTO t1 VALUES (3,4), (4,5);
DROP TABLE t1;
create table t1 (a text , b text);
create table t2 (a text , b text);
insert t1 values ("Duck, Duck", "goose");
insert t1 values ("Duck, Duck", "pidgeon");
insert t2 values ("We the people", "in order to perform");
insert t2 values ("a more perfect", "union");
select * from t1;
select * from t2;
select * from t1;
select * from t2;
create table words(a varchar(255));
create table words2(b varchar(255));
select * from t1;
select * from t2;
select * from words;
select * from words2;
drop table words;
drop table t1;
drop table t2;
drop table words2;
create database first;
create event ee1 on schedule at '2035-12-31 20:01:23' do set @a=5;
drop database first;
create database second;
create event ee2 on schedule at '2029-12-31 21:01:23' do set @a=5;
create event ee3 on schedule at '2030-12-31 22:01:23' do set @a=5;
drop database second;
create database third;
drop database third;
create database mysqldump_test_db;
create table t1 (id int);
create view v1 as select * from t1;
insert into t1 values (1232131);
insert into t1 values (4711);
insert into t1 values (3231);
insert into t1 values (0815);
drop view v1;
drop table t1;
drop database mysqldump_test_db;
DROP DATABASE IF EXISTS mysqldump_test_db;
CREATE DATABASE mysqldump_test_db;
DROP DATABASE mysqldump_test_db;
CREATE event e29938 ON SCHEDULE AT '2035-12-31 20:01:23' DO SET @bug29938=29938;
DROP EVENT e29938;
create database `test-database`;
create table test (a int);
drop database `test-database`;
DROP DATABASE IF EXISTS mysqldump_test_db;
CREATE DATABASE mysqldump_test_db;
CREATE VIEW v1(x, y) AS SELECT 'a', 'a';
SELECT view_definition
FROM INFORMATION_SCHEMA.VIEWS
WHERE table_schema = 'mysqldump_test_db' AND table_name = 'v1';
DROP DATABASE mysqldump_test_db;
SELECT view_definition
FROM INFORMATION_SCHEMA.VIEWS
WHERE table_schema = 'mysqldump_test_db' AND table_name = 'v1';
create table t1 (a int);
drop view v1;
drop table t1;
drop table if exists `load`;
create table `load` (a varchar(255));
select count(*) from `load`;
drop table `load`;
CREATE TABLE t1 (f1 INT);
CREATE PROCEDURE pr1 () SELECT "Meow";
CREATE EVENT ev1 ON SCHEDULE AT '2030-01-01 00:00:00' DO SELECT "Meow";
SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.routines
WHERE routine_name = 'pr1';
DROP EVENT ev1;
DROP TABLE t1;
DROP PROCEDURE pr1;
SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.routines
WHERE routine_name = 'pr1';
SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.routines
WHERE routine_name = 'pr1';
DROP EVENT IF EXISTS ev1;
DROP PROCEDURE IF EXISTS pr1;
DROP TRIGGER IF EXISTS tr1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT, b CHAR(10) CHARSET koi8r, c CHAR(10) CHARSET latin1);
CREATE TABLE t2 LIKE t1;
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a, b, c;
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a, b, c;
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a, b, c;
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a, b, c;
DROP TABLE t1, t2;
CREATE TABLE t1 (a BLOB) CHARSET latin1;
CREATE TABLE t2 LIKE t1;
SELECT LENGTH(a) FROM t2;
DROP TABLE t1, t2;
create table t1 (first char(28) , last varchar(37));
drop table t1;
CREATE TABLE `comment_table` (i INT COMMENT 'FIELD COMMENT') COMMENT = 'TABLE COMMENT';
DROP TABLE `comment_table`;
CREATE DATABASE `test-database`;
ALTER DATABASE `test-database` CHARACTER SET latin1 COLLATE latin1_swedish_ci;
ALTER DATABASE `test-database` CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci;
DROP DATABASE `test-database`;
CREATE DATABASE BUG52792;
CREATE TABLE t1 (c1 INT, c2 VARCHAR(20)) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1, 'aaa'), (2, 'bbb'), (3, 'ccc');
INSERT INTO t2 VALUES (1),(2),(3);
CREATE EVENT e1 ON SCHEDULE EVERY 1 SECOND DO DROP DATABASE BUG52792;
CREATE EVENT e2 ON SCHEDULE EVERY 1 SECOND DO DROP DATABASE BUG52792;
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
DROP TABLE t1;
DROP DATABASE IF EXISTS b12809202_db;
CREATE DATABASE b12809202_db;
CREATE TABLE b12809202_db.t1 (c1 INT);
CREATE TABLE b12809202_db.t2 (c1 INT);
DROP TABLE b12809202_db.t1;
DROP TABLE b12809202_db.t2;
DROP DATABASE b12809202_db;
DROP DATABASE IF EXISTS b12688860_db;
CREATE DATABASE b12688860_db;
DROP DATABASE b12688860_db;
DROP VIEW v1;
CREATE DATABASE `a\\k`;
CREATE TABLE `a\\k`.t1(i INT);
DROP DATABASE `a\\k`;
CREATE DATABASE dump_gis;
CREATE TABLE t1 (a GEOMETRY);
INSERT INTO t1 VALUES(ST_GeomFromText('LineString(1 1, 2 1, 2 2, 1 2, 1 1)'));
SELECT HEX(a) FROM t1;
DROP DATABASE dump_gis;
CREATE DATABASE db_20772273;
INSERT INTO t2 VALUES (3), (4);
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1;
DROP TABLE t2;
DROP DATABASE db_20772273;
CREATE DATABASE dump_json;
CREATE TABLE t1 (j JSON);
INSERT INTO t1 VALUES (JSON_ARRAY(1, 2, 3, "one", "two", "three"));
SELECT * FROM t1;
DROP DATABASE dump_json;
CREATE DATABASE dump_generated;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t2 (pk INTEGER, a INTEGER, b INTEGER,
                 sum INTEGER GENERATED ALWAYS AS (a+b),
                 c VARCHAR(16),
                 key k1(sum)
) engine=innodb;
INSERT INTO t2(pk, a, b, c) VALUES (1, 11, 12, 'oneone'), (2, 21, 22, 'twotwo');
SELECT * FROM t2;
DELETE FROM t2;
SELECT * FROM t2;
DELETE FROM t2;
SELECT * FROM t2;
DROP TABLE t2;
DROP DATABASE dump_generated;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.routines WHERE routine_schema = 'sys';
CREATE DATABASE bug25717383;
CREATE TABLE `tab
one` (a int);
CREATE VIEW `view
one` as SELECT * FROM `tab
one`;
CREATE PROCEDURE `proc
one`() SELECT * from `tab
one`;
CREATE TEMPORARY TABLE `temp
one` (id INT);
CREATE EVENT `event
one` ON SCHEDULE AT '2030-01-01 00:00:00' DO SET @a=5;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='bug25717383' AND ROUTINE_TYPE= 'PROCEDURE'
       ORDER BY ROUTINE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='bug25717383' AND ROUTINE_TYPE= 'PROCEDURE'
       ORDER BY ROUTINE_NAME;
DROP DATABASE bug25717383;
CREATE SCHEMA column_statistics_dump;
CREATE TABLE t1 (col1 INT);
INSERT INTO t1 VALUES (1), (2);
SELECT schema_name, table_name, column_name,
       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')
FROM information_schema.COLUMN_STATISTICS;
DROP SCHEMA column_statistics_dump;
CREATE DATABASE bug26171967;
INSERT INTO t1 VALUES (1000000), (1000001);
DROP DATABASE bug26171967;
CREATE TABLE t2(f1 INT, f2 INT INVISIBLE);
INSERT INTO t2(f1, f2) VALUES (10, 20), (20, 30);
DROP TABLE t1, t2;
CREATE TABLE t1 (my_row_id bigint unsigned NOT NULL AUTO_INCREMENT INVISIBLE, f INT,
                 PRIMARY KEY(my_row_id));
INSERT INTO t1 VALUES (1), (3), (7), (8), (4);
CREATE TABLE t2 (f1 INT, f2 INT INVISIBLE DEFAULT 10);
INSERT INTO t2 VALUES (1), (3), (7), (8), (4);
CREATE TABLE t3 AS SELECT * FROM t2;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (f INT NOT NULL PRIMARY KEY, my_row_id INT DEFAULT 580030);
SELECT * FROM t1;
CREATE TABLE t2 (f1 INT NOT NULL PRIMARY KEY, f2 INT, my_row_id INT DEFAULT 580030);
SELECT * FROM t2;
CREATE TABLE t3 (f1 INT NOT NULL PRIMARY KEY, my_row_id INT DEFAULT 580030);
SELECT * FROM t3;
SELECT my_row_id, f FROM t1;
SELECT my_row_id, f1, f2 FROM t2;
SELECT my_row_id, f1 FROM t3;
DROP TABLE t1, t2, t3;
CREATE DATABASE init_command_db;
CREATE TABLE init_command_db.t(a INT);
DROP DATABASE init_command_db;
CREATE DATABASE skip_views_db;
CREATE TABLE skip_views_db.t(a INT);
CREATE DATABASE skip_views_db2;
CREATE TABLE skip_views_db2.t(a INT);
DROP DATABASE skip_views_db;
DROP DATABASE skip_views_db2;
