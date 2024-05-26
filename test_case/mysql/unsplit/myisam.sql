drop table if exists t1,t2;
CREATE TABLE t1 (
  STRING_DATA char(255) default NULL,
  KEY string_data (STRING_DATA)
) charset latin1 ENGINE=MyISAM;
INSERT INTO t1 VALUES ('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO t1 VALUES ('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
INSERT INTO t1 VALUES ('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
INSERT INTO t1 VALUES ('FGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG');
INSERT INTO t1 VALUES ('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
INSERT INTO t1 VALUES ('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW');
drop table t1;
create table t1 (a tinyint not null auto_increment, b blob not null, primary key (a));
delete from t1 where (a & 1);
drop table t1;
create table t1 (a int not null auto_increment, b int not null, primary key (a), index(b));
insert into t1 (b) values (1),(2),(2),(2),(2);
drop table t1;
create table t1 (a int not null, b int not null, c int not null, primary key (a),key(b)) engine=myisam;
insert into t1 values (3,3,3),(1,1,1),(2,2,2),(4,4,4);
drop table t1;
CREATE TABLE t1 (a INT);
INSERT INTO  t1 VALUES (1), (2), (3);
LOCK TABLES t1 WRITE;
INSERT INTO  t1 VALUES (1), (2), (3);
DROP TABLE t1;
create table t1 ( t1 char(255), key(t1(250)));
insert t1 values ('137513751375137513751375137513751375137569516951695169516951695169516951695169');
insert t1 values ('178417841784178417841784178417841784178403420342034203420342034203420342034203');
insert t1 values ('213872387238723872387238723872387238723867376737673767376737673767376737673767');
insert t1 values ('242624262426242624262426242624262426242607890789078907890789078907890789078907');
insert t1 values ('256025602560256025602560256025602560256011701170117011701170117011701170117011');
insert t1 values ('276027602760276027602760276027602760276001610161016101610161016101610161016101');
insert t1 values ('281528152815281528152815281528152815281564956495649564956495649564956495649564');
insert t1 values ('292129212921292129212921292129212921292102100210021002100210021002100210021002');
insert t1 values ('380638063806380638063806380638063806380634483448344834483448344834483448344834');
insert t1 values ('411641164116411641164116411641164116411616301630163016301630163016301630163016');
insert t1 values ('420842084208420842084208420842084208420899889988998899889988998899889988998899');
insert t1 values ('438443844384438443844384438443844384438482448244824482448244824482448244824482');
insert t1 values ('443244324432443244324432443244324432443239613961396139613961396139613961396139');
insert t1 values ('485448544854485448544854485448544854485477847784778477847784778477847784778477');
insert t1 values ('494549454945494549454945494549454945494555275527552755275527552755275527552755');
insert t1 values ('538647864786478647864786478647864786478688918891889188918891889188918891889188');
insert t1 values ('565556555655565556555655565556555655565554845484548454845484548454845484548454');
insert t1 values ('607860786078607860786078607860786078607856665666566656665666566656665666566656');
insert t1 values ('640164016401640164016401640164016401640141274127412741274127412741274127412741');
insert t1 values ('719471947194719471947194719471947194719478717871787178717871787178717871787178');
insert t1 values ('742574257425742574257425742574257425742549604960496049604960496049604960496049');
insert t1 values ('887088708870887088708870887088708870887035963596359635963596359635963596359635');
insert t1 values ('917791779177917791779177917791779177917773857385738573857385738573857385738573');
insert t1 values ('933293329332933293329332933293329332933278987898789878987898789878987898789878');
insert t1 values ('963896389638963896389638963896389638963877807780778077807780778077807780778077');
delete from t1 where t1>'2';
insert t1 values ('70'), ('84'), ('60'), ('20'), ('76'), ('89'), ('49'), ('50'),
('88'), ('61'), ('42'), ('98'), ('39'), ('30'), ('25'), ('66'), ('61'), ('48'),
('80'), ('84'), ('98'), ('19'), ('91'), ('42'), ('47');
drop table t1;
create table t1 (i1 int, i2 int, i3 int, i4 int, i5 int, i6 int, i7 int, i8
int, i9 int, i10 int, i11 int, i12 int, i13 int, i14 int, i15 int, i16 int, i17
int, i18 int, i19 int, i20 int, i21 int, i22 int, i23 int, i24 int, i25 int,
i26 int, i27 int, i28 int, i29 int, i30 int, i31 int, i32 int, i33 int, i34
int, i35 int, i36 int, i37 int, i38 int, i39 int, i40 int, i41 int, i42 int,
i43 int, i44 int, i45 int, i46 int, i47 int, i48 int, i49 int, i50 int, i51
int, i52 int, i53 int, i54 int, i55 int, i56 int, i57 int, i58 int, i59 int,
i60 int, i61 int, i62 int, i63 int, i64 int, i65 int, i66 int, i67 int, i68
int, i69 int, i70 int, i71 int, i72 int, i73 int, i74 int, i75 int, i76 int,
i77 int, i78 int, i79 int, i80 int, i81 int, i82 int, i83 int, i84 int, i85
int, i86 int, i87 int, i88 int, i89 int, i90 int, i91 int, i92 int, i93 int,
i94 int, i95 int, i96 int, i97 int, i98 int, i99 int, i100 int, i101 int, i102
int, i103 int, i104 int, i105 int, i106 int, i107 int, i108 int, i109 int, i110
int, i111 int, i112 int, i113 int, i114 int, i115 int, i116 int, i117 int, i118
int, i119 int, i120 int, i121 int, i122 int, i123 int, i124 int, i125 int, i126
int, i127 int, i128 int, i129 int, i130 int, i131 int, i132 int, i133 int, i134
int, i135 int, i136 int, i137 int, i138 int, i139 int, i140 int, i141 int, i142
int, i143 int, i144 int, i145 int, i146 int, i147 int, i148 int, i149 int, i150
int, i151 int, i152 int, i153 int, i154 int, i155 int, i156 int, i157 int, i158
int, i159 int, i160 int, i161 int, i162 int, i163 int, i164 int, i165 int, i166
int, i167 int, i168 int, i169 int, i170 int, i171 int, i172 int, i173 int, i174
int, i175 int, i176 int, i177 int, i178 int, i179 int, i180 int, i181 int, i182
int, i183 int, i184 int, i185 int, i186 int, i187 int, i188 int, i189 int, i190
int, i191 int, i192 int, i193 int, i194 int, i195 int, i196 int, i197 int, i198
int, i199 int, i200 int, i201 int, i202 int, i203 int, i204 int, i205 int, i206
int, i207 int, i208 int, i209 int, i210 int, i211 int, i212 int, i213 int, i214
int, i215 int, i216 int, i217 int, i218 int, i219 int, i220 int, i221 int, i222
int, i223 int, i224 int, i225 int, i226 int, i227 int, i228 int, i229 int, i230
int, i231 int, i232 int, i233 int, i234 int, i235 int, i236 int, i237 int, i238
int, i239 int, i240 int, i241 int, i242 int, i243 int, i244 int, i245 int, i246
int, i247 int, i248 int, i249 int, i250 int, i251 int, i252 int, i253 int, i254
int, i255 int, i256 int, i257 int, i258 int, i259 int, i260 int, i261 int, i262
int, i263 int, i264 int, i265 int, i266 int, i267 int, i268 int, i269 int, i270
int, i271 int, i272 int, i273 int, i274 int, i275 int, i276 int, i277 int, i278
int, i279 int, i280 int, i281 int, i282 int, i283 int, i284 int, i285 int, i286
int, i287 int, i288 int, i289 int, i290 int, i291 int, i292 int, i293 int, i294
int, i295 int, i296 int, i297 int, i298 int, i299 int, i300 int, i301 int, i302
int, i303 int, i304 int, i305 int, i306 int, i307 int, i308 int, i309 int, i310
int, i311 int, i312 int, i313 int, i314 int, i315 int, i316 int, i317 int, i318
int, i319 int, i320 int, i321 int, i322 int, i323 int, i324 int, i325 int, i326
int, i327 int, i328 int, i329 int, i330 int, i331 int, i332 int, i333 int, i334
int, i335 int, i336 int, i337 int, i338 int, i339 int, i340 int, i341 int, i342
int, i343 int, i344 int, i345 int, i346 int, i347 int, i348 int, i349 int, i350
int, i351 int, i352 int, i353 int, i354 int, i355 int, i356 int, i357 int, i358
int, i359 int, i360 int, i361 int, i362 int, i363 int, i364 int, i365 int, i366
int, i367 int, i368 int, i369 int, i370 int, i371 int, i372 int, i373 int, i374
int, i375 int, i376 int, i377 int, i378 int, i379 int, i380 int, i381 int, i382
int, i383 int, i384 int, i385 int, i386 int, i387 int, i388 int, i389 int, i390
int, i391 int, i392 int, i393 int, i394 int, i395 int, i396 int, i397 int, i398
int, i399 int, i400 int, i401 int, i402 int, i403 int, i404 int, i405 int, i406
int, i407 int, i408 int, i409 int, i410 int, i411 int, i412 int, i413 int, i414
int, i415 int, i416 int, i417 int, i418 int, i419 int, i420 int, i421 int, i422
int, i423 int, i424 int, i425 int, i426 int, i427 int, i428 int, i429 int, i430
int, i431 int, i432 int, i433 int, i434 int, i435 int, i436 int, i437 int, i438
int, i439 int, i440 int, i441 int, i442 int, i443 int, i444 int, i445 int, i446
int, i447 int, i448 int, i449 int, i450 int, i451 int, i452 int, i453 int, i454
int, i455 int, i456 int, i457 int, i458 int, i459 int, i460 int, i461 int, i462
int, i463 int, i464 int, i465 int, i466 int, i467 int, i468 int, i469 int, i470
int, i471 int, i472 int, i473 int, i474 int, i475 int, i476 int, i477 int, i478
int, i479 int, i480 int, i481 int, i482 int, i483 int, i484 int, i485 int, i486
int, i487 int, i488 int, i489 int, i490 int, i491 int, i492 int, i493 int, i494
int, i495 int, i496 int, i497 int, i498 int, i499 int, i500 int, i501 int, i502
int, i503 int, i504 int, i505 int, i506 int, i507 int, i508 int, i509 int, i510
int, i511 int, i512 int, i513 int, i514 int, i515 int, i516 int, i517 int, i518
int, i519 int, i520 int, i521 int, i522 int, i523 int, i524 int, i525 int, i526
int, i527 int, i528 int, i529 int, i530 int, i531 int, i532 int, i533 int, i534
int, i535 int, i536 int, i537 int, i538 int, i539 int, i540 int, i541 int, i542
int, i543 int, i544 int, i545 int, i546 int, i547 int, i548 int, i549 int, i550
int, i551 int, i552 int, i553 int, i554 int, i555 int, i556 int, i557 int, i558
int, i559 int, i560 int, i561 int, i562 int, i563 int, i564 int, i565 int, i566
int, i567 int, i568 int, i569 int, i570 int, i571 int, i572 int, i573 int, i574
int, i575 int, i576 int, i577 int, i578 int, i579 int, i580 int, i581 int, i582
int, i583 int, i584 int, i585 int, i586 int, i587 int, i588 int, i589 int, i590
int, i591 int, i592 int, i593 int, i594 int, i595 int, i596 int, i597 int, i598
int, i599 int, i600 int, i601 int, i602 int, i603 int, i604 int, i605 int, i606
int, i607 int, i608 int, i609 int, i610 int, i611 int, i612 int, i613 int, i614
int, i615 int, i616 int, i617 int, i618 int, i619 int, i620 int, i621 int, i622
int, i623 int, i624 int, i625 int, i626 int, i627 int, i628 int, i629 int, i630
int, i631 int, i632 int, i633 int, i634 int, i635 int, i636 int, i637 int, i638
int, i639 int, i640 int, i641 int, i642 int, i643 int, i644 int, i645 int, i646
int, i647 int, i648 int, i649 int, i650 int, i651 int, i652 int, i653 int, i654
int, i655 int, i656 int, i657 int, i658 int, i659 int, i660 int, i661 int, i662
int, i663 int, i664 int, i665 int, i666 int, i667 int, i668 int, i669 int, i670
int, i671 int, i672 int, i673 int, i674 int, i675 int, i676 int, i677 int, i678
int, i679 int, i680 int, i681 int, i682 int, i683 int, i684 int, i685 int, i686
int, i687 int, i688 int, i689 int, i690 int, i691 int, i692 int, i693 int, i694
int, i695 int, i696 int, i697 int, i698 int, i699 int, i700 int, i701 int, i702
int, i703 int, i704 int, i705 int, i706 int, i707 int, i708 int, i709 int, i710
int, i711 int, i712 int, i713 int, i714 int, i715 int, i716 int, i717 int, i718
int, i719 int, i720 int, i721 int, i722 int, i723 int, i724 int, i725 int, i726
int, i727 int, i728 int, i729 int, i730 int, i731 int, i732 int, i733 int, i734
int, i735 int, i736 int, i737 int, i738 int, i739 int, i740 int, i741 int, i742
int, i743 int, i744 int, i745 int, i746 int, i747 int, i748 int, i749 int, i750
int, i751 int, i752 int, i753 int, i754 int, i755 int, i756 int, i757 int, i758
int, i759 int, i760 int, i761 int, i762 int, i763 int, i764 int, i765 int, i766
int, i767 int, i768 int, i769 int, i770 int, i771 int, i772 int, i773 int, i774
int, i775 int, i776 int, i777 int, i778 int, i779 int, i780 int, i781 int, i782
int, i783 int, i784 int, i785 int, i786 int, i787 int, i788 int, i789 int, i790
int, i791 int, i792 int, i793 int, i794 int, i795 int, i796 int, i797 int, i798
int, i799 int, i800 int, i801 int, i802 int, i803 int, i804 int, i805 int, i806
int, i807 int, i808 int, i809 int, i810 int, i811 int, i812 int, i813 int, i814
int, i815 int, i816 int, i817 int, i818 int, i819 int, i820 int, i821 int, i822
int, i823 int, i824 int, i825 int, i826 int, i827 int, i828 int, i829 int, i830
int, i831 int, i832 int, i833 int, i834 int, i835 int, i836 int, i837 int, i838
int, i839 int, i840 int, i841 int, i842 int, i843 int, i844 int, i845 int, i846
int, i847 int, i848 int, i849 int, i850 int, i851 int, i852 int, i853 int, i854
int, i855 int, i856 int, i857 int, i858 int, i859 int, i860 int, i861 int, i862
int, i863 int, i864 int, i865 int, i866 int, i867 int, i868 int, i869 int, i870
int, i871 int, i872 int, i873 int, i874 int, i875 int, i876 int, i877 int, i878
int, i879 int, i880 int, i881 int, i882 int, i883 int, i884 int, i885 int, i886
int, i887 int, i888 int, i889 int, i890 int, i891 int, i892 int, i893 int, i894
int, i895 int, i896 int, i897 int, i898 int, i899 int, i900 int, i901 int, i902
int, i903 int, i904 int, i905 int, i906 int, i907 int, i908 int, i909 int, i910
int, i911 int, i912 int, i913 int, i914 int, i915 int, i916 int, i917 int, i918
int, i919 int, i920 int, i921 int, i922 int, i923 int, i924 int, i925 int, i926
int, i927 int, i928 int, i929 int, i930 int, i931 int, i932 int, i933 int, i934
int, i935 int, i936 int, i937 int, i938 int, i939 int, i940 int, i941 int, i942
int, i943 int, i944 int, i945 int, i946 int, i947 int, i948 int, i949 int, i950
int, i951 int, i952 int, i953 int, i954 int, i955 int, i956 int, i957 int, i958
int, i959 int, i960 int, i961 int, i962 int, i963 int, i964 int, i965 int, i966
int, i967 int, i968 int, i969 int, i970 int, i971 int, i972 int, i973 int, i974
int, i975 int, i976 int, i977 int, i978 int, i979 int, i980 int, i981 int, i982
int, i983 int, i984 int, i985 int, i986 int, i987 int, i988 int, i989 int, i990
int, i991 int, i992 int, i993 int, i994 int, i995 int, i996 int, i997 int, i998
int, i999 int, i1000 int, b blob) row_format=dynamic;
insert into t1 values (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, "Sergei");
update t1 set b=repeat('a',256);
update t1 set i1=0, i2=0, i3=0, i4=0, i5=0, i6=0, i7=0;
delete from t1 where i8=1;
select i1,i2 from t1;
drop table t1;
CREATE TABLE t1 (a varchar(255), b varchar(255), c varchar(255), d varchar(255), e varchar(255));
DROP TABLE t1;
CREATE TABLE t1 (a int not null, b int, c int, key(b), key(c), key(a,b), key(c,a));
INSERT into t1 values (0, null, 0), (0, null, 1), (0, null, 2), (0, null,3), (1,1,4);
create table t2 (a int not null, b int, c int, key(b), key(c), key(a));
INSERT into t2 values (1,1,1), (2,2,2);
drop table t1,t2;
create table t1 (a int not null auto_increment primary key, b varchar(255));
insert into t1 (b) values (repeat('a',100)),(repeat('b',100)),(repeat('c',100));
update t1 set b=repeat(left(b,1),200) where a=1;
delete from t1 where (a & 1)= 0;
update t1 set b=repeat('e',200) where a=1;
update t1 set b=repeat(left(b,1),255) where a between 1 and 5;
update t1 set b=repeat(left(b,1),10) where a between 32 and 43;
update t1 set b=repeat(left(b,1),2) where a between 64 and 66;
update t1 set b=repeat(left(b,1),65) where a between 67 and 70;
insert into t1 (b) values (repeat('z',100));
update t1 set b="test" where left(b,1) > 'n';
drop table t1;
create table t1 ( a text collate latin1_swedish_ci not null, key a (a(20)));
insert into t1 values ('aaa   '),('aaa'),('aa');
select concat(a,'.') from t1 where a='aaa';
update t1 set a='bbb' where a='aaa';
drop table t1;
create table t1(a text not null, b text not null, c text not null, index (a(10),b(10),c(10)));
insert into t1 values('807780', '477', '165');
insert into t1 values('807780', '477', '162');
insert into t1 values('807780', '472', '162');
select * from t1 where a='807780' and b='477' and c='165';
drop table t1;
CREATE TABLE t1 (a varchar(150) NOT NULL, KEY (a)) charset latin1;
INSERT t1 VALUES ("can \tcan");
INSERT t1 VALUES ("can   can");
INSERT t1 VALUES ("can");
SELECT * FROM t1;
DROP TABLE t1;
create table t1 (a blob);
insert into t1 values('a '),('a');
alter table t1 add key(a(2));
drop table t1;
create table t1 (a int not null auto_increment primary key, b text not null, unique b (b(20)));
insert into t1 (b) values ('a'),('b'),('c');
update t1 set b='b\b' where a=2;
select * from t1;
delete from t1 where b='b';
drop table t1;
create table t1 (a int not null);
create table t2 (a int not null, primary key (a));
insert into t1 values (1);
insert into t2 values (1),(2);
select sql_big_result distinct t1.a from t1,t2;
drop table t1,t2;
create table t1 (
  c1 varchar(32),
  key (c1)
) engine=myisam;
alter table t1 disable keys;
insert into t1 values ('a'), ('b');
select c1 from t1 order by c1 limit 1;
drop table t1;
create table t1 (a int not null, primary key(a));
create table t2 (a int not null, b int not null, primary key(a,b));
insert into t1 values (1),(2),(3),(4),(5),(6);
insert into t2 values (1,1),(2,1);
lock tables t1 read local, t2 read local;
select straight_join * from t1,t2 force index (primary) where t1.a=t2.a;
select straight_join * from t1,t2 force index (primary) where t1.a=t2.a;
unlock tables;
drop table t1,t2;
CREATE TABLE t1 (c1 varchar(250) NOT NULL);
CREATE TABLE t2 (c1 varchar(250) NOT NULL, PRIMARY KEY (c1));
INSERT INTO t1 VALUES ('test000001'), ('test000002'), ('test000003');
INSERT INTO t2 VALUES ('test000002'), ('test000003'), ('test000004');
LOCK TABLES t1 READ LOCAL, t2 READ LOCAL;
SELECT t1.c1 AS t1c1, t2.c1 AS t2c1 FROM t1, t2
  WHERE t1.c1 = t2.c1 HAVING t1c1 != t2c1;
SELECT t1.c1 AS t1c1, t2.c1 AS t2c1 FROM t1, t2
  WHERE t1.c1 = t2.c1 HAVING t1c1 != t2c1;
UNLOCK TABLES;
DROP TABLE t1,t2;
create table t1 (a int, b varchar(200), c text not null) checksum=1;
create table t2 (a int, b varchar(200), c text not null) checksum=0;
insert t1 values (1, "aaa", "bbb"), (NULL, "", "ccccc"), (0, NULL, "");
insert t2 select * from t1;
drop table t1,t2;
create table t1 (a int, key (a));
alter table t1 disable keys;
create table t2 (a int);
insert t1 select * from t2;
alter table t1 enable keys;
alter table t1 engine=heap;
alter table t1 disable keys;
drop table t1,t2;
create table t1 ( a tinytext, b char(1), index idx (a(1),b) );
insert into t1 values (null,''), (null,'');
select count(*) from t1 where a is null;
drop table t1;
create table t1 (c1 int, c2 varchar(4) not null default '',
                 key(c2(3))) default charset=utf8mb3;
insert into t1 values (1,'A'), (2, 'B'), (3, 'A');
update t1 set c2='A  B' where c1=2;
drop table t1;
create table t1 (c1 int);
insert into t1 values (1),(2),(3),(4);
delete from t1 where c1 = 1;
create table t2 as select * from t1;
drop table t1, t2;
create table t1 (a int, key(a));
insert into t1 values (0),(1),(2),(3),(4);
insert into t1 select NULL from t1;
insert into t1 values (11);
delete from t1 where a=11;
insert into t1 values (11);
delete from t1 where a=11;
insert into t1 values (11);
delete from t1 where a=11;
insert into t1 values (11);
delete from t1 where a=11;
insert into t1 values (11);
delete from t1 where a=11;
drop table t1;
create table t1 (
  a char(3), b char(4), c char(5), d char(6),
  key(a,b,c,d)
);
insert into t1 values ('bcd','def1', NULL, 'zz');
insert into t1 values ('bcd','def2', NULL, 'zz');
insert into t1 values ('bce','def1', 'yuu', NULL);
insert into t1 values ('bce','def2', NULL, 'quux');
delete from t1;
drop table t1;
create table t1(
  cip INT NOT NULL,
  time TIME NOT NULL,
  score INT NOT NULL DEFAULT 0,
  bob TINYBLOB
);
insert into t1 (cip, time) VALUES (1, '00:01'), (2, '00:02'), (3,'00:03');
insert into t1 (cip, bob, time) VALUES (4, 'a', '00:04'), (5, 'b', '00:05'), 
                                       (6, 'c', '00:06');
select * from t1 where bob is null and cip=1;
create index bug on t1 (bob(22), cip, time);
select * from t1 where bob is null and cip=1;
drop table t1;
create table t1 (
  id1 int not null auto_increment,
  id2 int not null default '0',
  t text not null,
  primary key  (id1),
  key x (id2, t(32))
) engine=myisam;
insert into t1 (id2, t) values
(10, 'abc'), (10, 'abc'), (10, 'abc'),
(20, 'abc'), (20, 'abc'), (20, 'def'),
(10, 'abc'), (10, 'abc');
drop table t1;
CREATE TABLE t1(a TINYINT, KEY(a)) ENGINE=MyISAM;
INSERT INTO t1 VALUES(1);
SELECT MAX(a) FROM t1 IGNORE INDEX(a);
ALTER TABLE t1 DISABLE KEYS;
SELECT MAX(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a CHAR(9), b VARCHAR(7)) ENGINE=MyISAM;
INSERT INTO t1(a) VALUES('xxxxxxxxx'),('xxxxxxxxx');
UPDATE t1 AS ta1,t1 AS ta2 SET ta1.b='aaaaaa',ta2.b='bbbbbb';
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
  `_id` int(11) NOT NULL default '0',
  `url` text,
  `email` text,
  `description` text,
  `loverlap` int(11) default NULL,
  `roverlap` int(11) default NULL,
  `lneighbor_id` int(11) default NULL,
  `rneighbor_id` int(11) default NULL,
  `length_` int(11) default NULL,
  `sequence` mediumtext,
  `name` text,
  `_obj_class` text NOT NULL,
  PRIMARY KEY  (`_id`),
  UNIQUE KEY `sequence_name_index` (`name`(50)),
  KEY (`length_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES
  (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample1',''),
  (2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample2',''),
  (3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample3',''),
  (4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample4',''),
  (5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample5',''),
  (6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample6',''),
  (7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample7',''),
  (8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample8',''),
  (9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample9','');
SELECT _id FROM t1;
DELETE FROM t1 WHERE _id < 8;
SELECT _id FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
  `_id` int(11) NOT NULL default '0',
  `url` text,
  `email` text,
  `description` text,
  `loverlap` int(11) default NULL,
  `roverlap` int(11) default NULL,
  `lneighbor_id` int(11) default NULL,
  `rneighbor_id` int(11) default NULL,
  `length_` int(11) default NULL,
  `sequence` mediumtext,
  `name` text,
  `_obj_class` text NOT NULL,
  PRIMARY KEY  (`_id`),
  UNIQUE KEY `sequence_name_index` (`name`(50)),
  KEY (`length_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES
  (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample1',''),
  (2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample2',''),
  (3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample3',''),
  (4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample4',''),
  (5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample5',''),
  (6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample6',''),
  (7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample7',''),
  (8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample8',''),
  (9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sample9','');
SELECT _id FROM t1;
DELETE FROM t1 WHERE _id < 8;
SELECT _id FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a VARCHAR(16));
INSERT INTO t1 VALUES('aaaaaaaa'),(NULL);
UPDATE t1 AS ta1, t1 AS ta2 SET ta1.a='aaaaaaaaaaaaaaaa';
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1),(2);
UPDATE t1,t1 AS t2 SET t1.a=t1.a+2 WHERE t1.a=t2.a-1;
SELECT * FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1 (c1 TEXT) AVG_ROW_LENGTH=70100 MAX_ROWS=4100100100;
DROP TABLE t1;
CREATE TABLE t1 (c1 TEXT NOT NULL, KEY c1 (c1(10))) charset latin1 ENGINE=MyISAM;
INSERT INTO t1 VALUES
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)), (CHAR(9,65)),
  (''), (''), (''), (''),
  (' B'), (' B'), (' B'), (' B');
SELECT DISTINCT COUNT(*) FROM t1 WHERE c1 = '';
SELECT DISTINCT length(c1), c1 FROM t1 WHERE c1 = '';
DROP TABLE t1;
drop table if exists t1;
create table t1 (a int);
insert into t1 values (1),(2),(3),(4),(5);
lock table t1 read local;
unlock tables;
delete from t1 where a>=3 and a<=4;
lock table t1 read local;
unlock tables;
insert into t1 values (10),(11),(12);
select * from t1;
drop table t1;
create table t1 (a int, b varchar(30) default "hello");
insert into t1 (a) values (1),(2),(3),(4),(5);
lock table t1 read local;
unlock tables;
delete from t1 where a>=3 and a<=4;
lock table t1 read local;
unlock tables;
insert into t1 (a) values (10),(11),(12);
select a from t1;
drop table t1;
create table t1 (a int, key(a));
insert into t1 values (1),(2),(3),(4),(NULL),(NULL),(NULL),(NULL);
alter table t1 disable keys;
alter table t1 enable keys;
drop table t1;
create table t1 (c1 int) engine=myisam pack_keys=0;
create table t2 (c1 int) engine=myisam pack_keys=1;
create table t3 (c1 int) engine=myisam pack_keys=default;
drop table t1, t2, t3;
CREATE TABLE t1(a INT, b INT, KEY inx (a), UNIQUE KEY uinx (b)) ENGINE=MyISAM;
INSERT INTO t1(a,b) VALUES (1,1),(2,2),(3,3),(4,4),(5,5);
SELECT a FROM t1 FORCE INDEX (inx) WHERE a=1;
ALTER TABLE t1 DISABLE KEYS;
SELECT a FROM t1 FORCE INDEX (inx) WHERE a=1;
SELECT a FROM t1 USE INDEX (inx) WHERE a=1;
SELECT b FROM t1 FORCE INDEX (uinx) WHERE b=1;
SELECT b FROM t1 USE INDEX (uinx) WHERE b=1;
SELECT a FROM t1 FORCE INDEX (inx,uinx) WHERE a=1;
ALTER TABLE t1 ENABLE KEYS;
SELECT a FROM t1 FORCE INDEX (inx) WHERE a=1;
DROP TABLE t1;
CREATE TABLE t1 (c1 INT, c2 INT, UNIQUE INDEX (c1), INDEX (c2)) ENGINE=MYISAM;
INSERT INTO t1 VALUES (1,1);
ALTER TABLE t1 DISABLE KEYS;
ALTER TABLE t1 ENABLE KEYS;
ALTER TABLE t1 DISABLE KEYS;
ALTER TABLE t1 ENABLE KEYS;
ALTER TABLE t1 DISABLE KEYS;
ALTER TABLE t1 ENABLE KEYS;
DROP TABLE t1;
CREATE TABLE t1 (id int NOT NULL, ref int NOT NULL, INDEX (id)) ENGINE=MyISAM;
CREATE TABLE t2 LIKE t1;
INSERT INTO t2 (id, ref) VALUES (1,3), (2,1), (3,2), (4,5), (4,4);
INSERT INTO t1 SELECT * FROM t2;
SELECT * FROM t1 AS a INNER JOIN t1 AS b USING (id) WHERE a.ref < b.ref;
SELECT * FROM t1;
DELETE FROM a USING t1 AS a INNER JOIN t1 AS b USING (id) WHERE a.ref < b.ref;
SELECT * FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT) ENGINE=MyISAM CHECKSUM=1 ROW_FORMAT=DYNAMIC;
INSERT INTO t1 VALUES (0);
UPDATE t1 SET a=1;
SELECT a FROM t1;
INSERT INTO t1 VALUES (0), (5), (4), (2);
UPDATE t1 SET a=2;
SELECT a FROM t1;
DROP TABLE t1;
CREATE TABLE t1(
a VARCHAR(1), b VARCHAR(1), c VARCHAR(1),
f VARCHAR(1), g VARCHAR(1), h VARCHAR(1),
i VARCHAR(1), j VARCHAR(1), k VARCHAR(1)) CHECKSUM=1;
INSERT INTO t1 VALUES('', '', '', '', '', '', '', '', '');
DROP TABLE t1;
CREATE TABLE t1(a INT);
SELECT 1 FROM t1 AS a1, t1 AS a2, t1 AS a3, t1 AS a4 FOR UPDATE;
SELECT TABLE_ROWS, DATA_LENGTH FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME='t1';
DROP TABLE t1;
create table t1 (a int not null, key `a` (a) key_block_size=1024);
drop table t1;
create table t1 (a int not null, key `a` (a) key_block_size=2048);
drop table t1;
create table t1 (a int not null, key `a` (a) key_block_size=512);
drop table t1;
create table t1 (a int not null, key `a` (a) key_block_size=1025);
drop table t1;
CREATE TABLE t1 (
  c1 INT,
  c2 VARCHAR(300),
  KEY (c1) KEY_BLOCK_SIZE 1024,
  KEY (c2) KEY_BLOCK_SIZE 8192
  ) charset latin1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
DELETE FROM t1 WHERE c1 >= 10;
DROP TABLE t1;
CREATE TABLE t1 (
  c1 CHAR(130),
  c2 VARCHAR(1)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES(REPEAT("a",128), 'b');
DROP TABLE t1;
CREATE TABLE t1 (
  c1 CHAR(130),
  c2 VARCHAR(1)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES(REPEAT("a",128), 'b');
DROP TABLE t1;
CREATE TABLE t1 (
  c1 CHAR(130),
  c2 VARCHAR(1)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES(REPEAT("a",128), 'b');
INSERT INTO t1 VALUES('b', 'b');
INSERT INTO t1 VALUES('c', 'b');
DELETE FROM t1 WHERE c1='b';
DROP TABLE t1;
CREATE TABLE t1 (
  c1 CHAR(130),
  c2 VARCHAR(1),
  KEY (c1)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES ('a', 'b');
UPDATE t1 SET c1=REPEAT("a",128) LIMIT 90;
ALTER TABLE t1 ENGINE=MyISAM;
DROP TABLE t1;
CREATE TABLE t1 (
  c1 CHAR(50),
  c2 VARCHAR(1)
) ENGINE=MyISAM DEFAULT CHARSET utf8mb3;
INSERT INTO t1 VALUES(REPEAT(_utf8mb3 x'e0ae85',43), 'b');
DROP TABLE t1;
CREATE TABLE t1 (
  c1 CHAR(50),
  c2 VARCHAR(1)
) ENGINE=MyISAM DEFAULT CHARSET utf8mb3;
INSERT INTO t1 VALUES(REPEAT(_utf8mb3 x'e0ae85',43), 'b');
DROP TABLE t1;
CREATE TABLE t1 (
  c1 CHAR(50),
  c2 VARCHAR(1)
) ENGINE=MyISAM DEFAULT CHARSET utf8mb3;
INSERT INTO t1 VALUES(REPEAT(_utf8mb3 x'e0ae85',43), 'b');
INSERT INTO t1 VALUES('b', 'b');
INSERT INTO t1 VALUES('c', 'b');
DELETE FROM t1 WHERE c1='b';
DROP TABLE t1;
CREATE TABLE t1 (
  c1 CHAR(50),
  c2 VARCHAR(1),
  KEY (c1)
) ENGINE=MyISAM DEFAULT CHARSET utf8mb3;
INSERT INTO t1 VALUES ('a', 'b');
UPDATE t1 SET c1=REPEAT(_utf8mb3 x'e0ae85',43) LIMIT 90;
ALTER TABLE t1 ENGINE=MyISAM;
DROP TABLE t1;
CREATE TABLE t1 (
  c1 VARCHAR(10) NOT NULL,
  c2 CHAR(10) DEFAULT NULL,
  c3 VARCHAR(10) NOT NULL,
  KEY (c1),
  KEY (c2)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 PACK_KEYS=0;
DROP TABLE t1;
CREATE TABLE t1 (
  c INT,
  d bit(1),
  e INT,
  f VARCHAR(1),
  g BIT(1),
  h BIT(1),
  KEY (h, d, e, g)
);
INSERT INTO t1 VALUES
  (  3, 1, 1, 'a', 0, 0 ),
  (  3, 1, 5, 'a', 0, 0 ),
  ( 10, 1, 2, 'a', 0, 1 ),
  ( 10, 1, 3, 'a', 0, 1 ),
  ( 10, 1, 4, 'a', 0, 1 );
SELECT f FROM t1 WHERE d = 1 AND e = 2 AND g = 0 AND h = 1;
SELECT h+0, d + 0, e, g + 0 FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (line LINESTRING NOT NULL) engine=myisam;
CREATE TABLE t2 (line LINESTRING NOT NULL) engine=myisam;
CREATE TABLE t3 select * from t1;
drop table t1,t2,t3;
CREATE TABLE t1(a INT, b CHAR(10), KEY(a), KEY(b)) charset latin1;
INSERT INTO t1 VALUES(1,'0'),(2,'0'),(3,'0'),(4,'0'),(5,'0'),
                     (6,'0'),(7,'0');
INSERT INTO t1 SELECT a+10,b FROM t1;
INSERT INTO t1 SELECT a+20,b FROM t1;
INSERT INTO t1 SELECT a+40,b FROM t1;
INSERT INTO t1 SELECT a+80,b FROM t1;
INSERT INTO t1 SELECT a+160,b FROM t1;
INSERT INTO t1 SELECT a+320,b FROM t1;
INSERT INTO t1 SELECT a+640,b FROM t1;
INSERT INTO t1 SELECT a+1280,b FROM t1;
INSERT INTO t1 SELECT a+2560,b FROM t1;
INSERT INTO t1 SELECT a+5120,b FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT, b LONGTEXT, UNIQUE(a));
DROP TABLE t1;
CREATE TABLE t1(a INT, b BIT(1));
INSERT INTO t1 VALUES(1, 0), (2, 1);
CREATE TABLE t2 SELECT * FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1(a CHAR(255), KEY(a)) charset latin1;
SELECT * FROM t1, t1 AS a1;
INSERT INTO t1 VALUES
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0');
INSERT INTO t1 VALUES('1');
SELECT * FROM t1, t1 AS a1 WHERE t1.a=1 AND a1.a=1;
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1),(2);
DELETE FROM t1 WHERE a=1;
LOCK TABLE t1 WRITE;
INSERT INTO t1 VALUES(3);
UNLOCK TABLES;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT, KEY(a));
ALTER TABLE t1 DISABLE KEYS;
SELECT @before=@after;
DROP TABLE t1;
CREATE TABLE t1 (
  a int NOT NULL
) engine= myisam;
CREATE TABLE t2 (
  a int NOT NULL,
  b int NOT NULL,
  filler char(100) DEFAULT NULL,
  KEY a (a,b)
) engine= myisam;
insert into t1 values (0),(1),(2),(3),(4);
insert into t2 select A.a + 10 *B.a, 1, 'filler' from t1 A, t1 B;
select * from t1, t2 where t2.a=t1.a and t2.b + 1;
drop table t1,t2;
SELECT @@global.myisam_recover_options;
CREATE TABLE t1 (a INT, KEY (a)) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1), (2);
ALTER TABLE t1 ENGINE = MyISAM;
DROP TABLE t1;
CREATE TABLE t1 (f1 year, key k1(f1)) ENGINE=MYISAM;
INSERT INTO t1 VALUES(0000),(0000);
SELECT * FROM t1 FORCE INDEX(k1) WHERE f1 = 'lhsi';
DROP TABLE t1;
CREATE TABLE t1 (
  col1 VARCHAR(255) DEFAULT NULL,
  col1_id INT(11) DEFAULT NULL,
  KEY col1 (col1),
  KEY col1_id (col1_id)
) charset latin1 ENGINE=MyISAM;
INSERT INTO t1 (col1, col1_id) VALUES
  ('5cm', 10000), ('people', 10000), ('king', 10000), ('queen', 10000),
  ('minister', 10000), ('servent', 13000);
INSERT INTO t1 (col1, col1_id)
  SELECT col1, col1_id FROM t1 WHERE col1 <> '5cm';
INSERT INTO t1 (col1, col1_id)
  SELECT col1, col1_id FROM t1 WHERE col1 <> '5cm';
INSERT INTO t1 (col1, col1_id)
  SELECT col1, col1_id FROM t1 WHERE col1 <> '5cm';
INSERT INTO t1 (col1, col1_id) VALUES
  ('5cm ', 10000), ('5cm ', 10000);
SELECT col1, hex(col1), col1_id, count(*) from t1
  WHERE col1= '5cm' GROUP BY hex(col1), col1_id;
UPDATE t1 SET col1_id= 1414 WHERE col1= '5cm';
DELETE FROM t1 WHERE col1= '5cm';
DROP TABLE t1;
CREATE TABLE t1 (
  col1 VARCHAR(255) DEFAULT NULL,
  col1_dummy VARCHAR(25) DEFAULT NULL,
  col1_id INT(11) DEFAULT NULL,
  col1_id_dummy INT(10) DEFAULT NULL,

  KEY col1 (col1, col1_dummy),
  KEY col1_id (col1, col1_id_dummy)
) charset latin1 ENGINE=MyISAM;
INSERT INTO t1 (col1, col1_dummy, col1_id, col1_id_dummy) VALUES
  ('5cm', '5cm' , 10000, 100), ('people', 'people', 10000, 100),
  ('king', 'king' , 10000, 100), ('queen', 'queen', 10000, 100),
  ('minister', 'minister', 10000, 100), ('servent', 'servent', 13000, 100);
INSERT INTO t1 (col1, col1_dummy, col1_id, col1_id_dummy)
  SELECT col1, col1_dummy, col1_id, col1_id_dummy FROM t1
    WHERE col1 <> '5cm';
INSERT INTO t1 (col1, col1_dummy, col1_id, col1_id_dummy)
  SELECT col1, col1_dummy, col1_id, col1_id_dummy FROM t1
    WHERE col1 <> '5cm';
INSERT INTO t1 (col1, col1_dummy, col1_id, col1_id_dummy)
  SELECT col1, col1_dummy, col1_id, col1_id_dummy FROM t1
  WHERE col1 <> '5cm';
INSERT INTO t1 (col1, col1_dummy, col1_id, col1_id_dummy) VALUES
  ('5cm ', '5cm ',  10000, 100), ('5cm ', '5cm ', 10000, 100);
UPDATE t1 SET col1_id= 1414 WHERE col1= '5cm' AND col1_dummy= '5cm';
DELETE FROM t1 WHERE col1= '5cm' AND col1_dummy= '5cm';
DROP TABLE t1;
