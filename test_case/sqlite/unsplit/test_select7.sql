create temp table t1(x);
insert into t1 values('amx');
insert into t1 values('anx');
insert into t1 values('amy');
insert into t1 values('bmy');
select * from t1 where x like 'a__'
        intersect select * from t1 where x like '_m_'
        intersect select * from t1 where x like '__x';
CREATE TABLE x(id integer primary key, a TEXT NULL);
INSERT INTO x (a) VALUES ('first');
CREATE TABLE tempx(id integer primary key, a TEXT NULL);
INSERT INTO tempx (a) VALUES ('t-first');
CREATE VIEW tv1 AS SELECT x.id, tx.id FROM x JOIN tempx tx ON tx.id=x.id;
CREATE VIEW tv1b AS SELECT x.id, tx.id FROM x JOIN tempx tx on tx.id=x.id;
CREATE VIEW tv2 AS SELECT * FROM tv1 UNION SELECT * FROM tv1b;
SELECT * FROM tv2;
SELECT * FROM sqlite_master ORDER BY name;
SELECT * FROM (SELECT * FROM sqlite_master) GROUP BY name;
CREATE TABLE IF NOT EXISTS photo(pk integer primary key, x);
CREATE TABLE IF NOT EXISTS tag(pk integer primary key, fk int, name);
SELECT P.pk from PHOTO P WHERE NOT EXISTS ( 
           SELECT T2.pk from TAG T2 WHERE T2.fk = P.pk 
           EXCEPT 
           SELECT T3.pk from TAG T3 WHERE T3.fk = P.pk AND T3.name LIKE '%foo%'
      );
INSERT INTO photo VALUES(1,1);
INSERT INTO photo VALUES(2,2);
INSERT INTO photo VALUES(3,3);
INSERT INTO tag VALUES(11,1,'one');
INSERT INTO tag VALUES(12,1,'two');
INSERT INTO tag VALUES(21,1,'one-b');
SELECT P.pk from PHOTO P WHERE NOT EXISTS ( 
           SELECT T2.pk from TAG T2 WHERE T2.fk = P.pk 
           EXCEPT 
           SELECT T3.pk from TAG T3 WHERE T3.fk = P.pk AND T3.name LIKE '%foo%'
      );
CREATE TABLE t2(a,b);
SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30 UNION ALL SELECT 31 UNION ALL SELECT 32 UNION ALL SELECT 33 UNION ALL SELECT 34 UNION ALL SELECT 35 UNION ALL SELECT 36 UNION ALL SELECT 37 UNION ALL SELECT 38 UNION ALL SELECT 39 UNION ALL SELECT 40 UNION ALL SELECT 41 UNION ALL SELECT 42 UNION ALL SELECT 43 UNION ALL SELECT 44 UNION ALL SELECT 45 UNION ALL SELECT 46 UNION ALL SELECT 47 UNION ALL SELECT 48 UNION ALL SELECT 49 UNION ALL SELECT 50 UNION ALL SELECT 51 UNION ALL SELECT 52 UNION ALL SELECT 53 UNION ALL SELECT 54 UNION ALL SELECT 55 UNION ALL SELECT 56 UNION ALL SELECT 57 UNION ALL SELECT 58 UNION ALL SELECT 59 UNION ALL SELECT 60 UNION ALL SELECT 61 UNION ALL SELECT 62 UNION ALL SELECT 63 UNION ALL SELECT 64 UNION ALL SELECT 65 UNION ALL SELECT 66 UNION ALL SELECT 67 UNION ALL SELECT 68 UNION ALL SELECT 69 UNION ALL SELECT 70 UNION ALL SELECT 71 UNION ALL SELECT 72 UNION ALL SELECT 73 UNION ALL SELECT 74 UNION ALL SELECT 75 UNION ALL SELECT 76 UNION ALL SELECT 77 UNION ALL SELECT 78 UNION ALL SELECT 79 UNION ALL SELECT 80 UNION ALL SELECT 81 UNION ALL SELECT 82 UNION ALL SELECT 83 UNION ALL SELECT 84 UNION ALL SELECT 85 UNION ALL SELECT 86 UNION ALL SELECT 87 UNION ALL SELECT 88 UNION ALL SELECT 89 UNION ALL SELECT 90 UNION ALL SELECT 91 UNION ALL SELECT 92 UNION ALL SELECT 93 UNION ALL SELECT 94 UNION ALL SELECT 95 UNION ALL SELECT 96 UNION ALL SELECT 97 UNION ALL SELECT 98 UNION ALL SELECT 99 UNION ALL SELECT 100 UNION ALL SELECT 101 UNION ALL SELECT 102 UNION ALL SELECT 103 UNION ALL SELECT 104 UNION ALL SELECT 105 UNION ALL SELECT 106 UNION ALL SELECT 107 UNION ALL SELECT 108 UNION ALL SELECT 109 UNION ALL SELECT 110 UNION ALL SELECT 111 UNION ALL SELECT 112 UNION ALL SELECT 113 UNION ALL SELECT 114 UNION ALL SELECT 115 UNION ALL SELECT 116 UNION ALL SELECT 117 UNION ALL SELECT 118 UNION ALL SELECT 119 UNION ALL SELECT 120 UNION ALL SELECT 121 UNION ALL SELECT 122 UNION ALL SELECT 123 UNION ALL SELECT 124 UNION ALL SELECT 125 UNION ALL SELECT 126 UNION ALL SELECT 127 UNION ALL SELECT 128 UNION ALL SELECT 129 UNION ALL SELECT 130 UNION ALL SELECT 131 UNION ALL SELECT 132 UNION ALL SELECT 133 UNION ALL SELECT 134 UNION ALL SELECT 135 UNION ALL SELECT 136 UNION ALL SELECT 137 UNION ALL SELECT 138 UNION ALL SELECT 139 UNION ALL SELECT 140 UNION ALL SELECT 141 UNION ALL SELECT 142 UNION ALL SELECT 143 UNION ALL SELECT 144 UNION ALL SELECT 145 UNION ALL SELECT 146 UNION ALL SELECT 147 UNION ALL SELECT 148 UNION ALL SELECT 149 UNION ALL SELECT 150 UNION ALL SELECT 151 UNION ALL SELECT 152 UNION ALL SELECT 153 UNION ALL SELECT 154 UNION ALL SELECT 155 UNION ALL SELECT 156 UNION ALL SELECT 157 UNION ALL SELECT 158 UNION ALL SELECT 159 UNION ALL SELECT 160 UNION ALL SELECT 161 UNION ALL SELECT 162 UNION ALL SELECT 163 UNION ALL SELECT 164 UNION ALL SELECT 165 UNION ALL SELECT 166 UNION ALL SELECT 167 UNION ALL SELECT 168 UNION ALL SELECT 169 UNION ALL SELECT 170 UNION ALL SELECT 171 UNION ALL SELECT 172 UNION ALL SELECT 173 UNION ALL SELECT 174 UNION ALL SELECT 175 UNION ALL SELECT 176 UNION ALL SELECT 177 UNION ALL SELECT 178 UNION ALL SELECT 179 UNION ALL SELECT 180 UNION ALL SELECT 181 UNION ALL SELECT 182 UNION ALL SELECT 183 UNION ALL SELECT 184 UNION ALL SELECT 185 UNION ALL SELECT 186 UNION ALL SELECT 187 UNION ALL SELECT 188 UNION ALL SELECT 189 UNION ALL SELECT 190 UNION ALL SELECT 191 UNION ALL SELECT 192 UNION ALL SELECT 193 UNION ALL SELECT 194 UNION ALL SELECT 195 UNION ALL SELECT 196 UNION ALL SELECT 197 UNION ALL SELECT 198 UNION ALL SELECT 199 UNION ALL SELECT 200 UNION ALL SELECT 201 UNION ALL SELECT 202 UNION ALL SELECT 203 UNION ALL SELECT 204 UNION ALL SELECT 205 UNION ALL SELECT 206 UNION ALL SELECT 207 UNION ALL SELECT 208 UNION ALL SELECT 209 UNION ALL SELECT 210 UNION ALL SELECT 211 UNION ALL SELECT 212 UNION ALL SELECT 213 UNION ALL SELECT 214 UNION ALL SELECT 215 UNION ALL SELECT 216 UNION ALL SELECT 217 UNION ALL SELECT 218 UNION ALL SELECT 219 UNION ALL SELECT 220 UNION ALL SELECT 221 UNION ALL SELECT 222 UNION ALL SELECT 223 UNION ALL SELECT 224 UNION ALL SELECT 225 UNION ALL SELECT 226 UNION ALL SELECT 227 UNION ALL SELECT 228 UNION ALL SELECT 229 UNION ALL SELECT 230 UNION ALL SELECT 231 UNION ALL SELECT 232 UNION ALL SELECT 233 UNION ALL SELECT 234 UNION ALL SELECT 235 UNION ALL SELECT 236 UNION ALL SELECT 237 UNION ALL SELECT 238 UNION ALL SELECT 239 UNION ALL SELECT 240 UNION ALL SELECT 241 UNION ALL SELECT 242 UNION ALL SELECT 243 UNION ALL SELECT 244 UNION ALL SELECT 245 UNION ALL SELECT 246 UNION ALL SELECT 247 UNION ALL SELECT 248 UNION ALL SELECT 249 UNION ALL SELECT 250 UNION ALL SELECT 251 UNION ALL SELECT 252 UNION ALL SELECT 253 UNION ALL SELECT 254 UNION ALL SELECT 255 UNION ALL SELECT 256 UNION ALL SELECT 257 UNION ALL SELECT 258 UNION ALL SELECT 259 UNION ALL SELECT 260 UNION ALL SELECT 261 UNION ALL SELECT 262 UNION ALL SELECT 263 UNION ALL SELECT 264 UNION ALL SELECT 265 UNION ALL SELECT 266 UNION ALL SELECT 267 UNION ALL SELECT 268 UNION ALL SELECT 269 UNION ALL SELECT 270 UNION ALL SELECT 271 UNION ALL SELECT 272 UNION ALL SELECT 273 UNION ALL SELECT 274 UNION ALL SELECT 275 UNION ALL SELECT 276 UNION ALL SELECT 277 UNION ALL SELECT 278 UNION ALL SELECT 279 UNION ALL SELECT 280 UNION ALL SELECT 281 UNION ALL SELECT 282 UNION ALL SELECT 283 UNION ALL SELECT 284 UNION ALL SELECT 285 UNION ALL SELECT 286 UNION ALL SELECT 287 UNION ALL SELECT 288 UNION ALL SELECT 289 UNION ALL SELECT 290 UNION ALL SELECT 291 UNION ALL SELECT 292 UNION ALL SELECT 293 UNION ALL SELECT 294 UNION ALL SELECT 295 UNION ALL SELECT 296 UNION ALL SELECT 297 UNION ALL SELECT 298 UNION ALL SELECT 299 UNION ALL SELECT 300 UNION ALL SELECT 301 UNION ALL SELECT 302 UNION ALL SELECT 303 UNION ALL SELECT 304 UNION ALL SELECT 305 UNION ALL SELECT 306 UNION ALL SELECT 307 UNION ALL SELECT 308 UNION ALL SELECT 309 UNION ALL SELECT 310 UNION ALL SELECT 311 UNION ALL SELECT 312 UNION ALL SELECT 313 UNION ALL SELECT 314 UNION ALL SELECT 315 UNION ALL SELECT 316 UNION ALL SELECT 317 UNION ALL SELECT 318 UNION ALL SELECT 319 UNION ALL SELECT 320 UNION ALL SELECT 321 UNION ALL SELECT 322 UNION ALL SELECT 323 UNION ALL SELECT 324 UNION ALL SELECT 325 UNION ALL SELECT 326 UNION ALL SELECT 327 UNION ALL SELECT 328 UNION ALL SELECT 329 UNION ALL SELECT 330 UNION ALL SELECT 331 UNION ALL SELECT 332 UNION ALL SELECT 333 UNION ALL SELECT 334 UNION ALL SELECT 335 UNION ALL SELECT 336 UNION ALL SELECT 337 UNION ALL SELECT 338 UNION ALL SELECT 339 UNION ALL SELECT 340 UNION ALL SELECT 341 UNION ALL SELECT 342 UNION ALL SELECT 343 UNION ALL SELECT 344 UNION ALL SELECT 345 UNION ALL SELECT 346 UNION ALL SELECT 347 UNION ALL SELECT 348 UNION ALL SELECT 349 UNION ALL SELECT 350 UNION ALL SELECT 351 UNION ALL SELECT 352 UNION ALL SELECT 353 UNION ALL SELECT 354 UNION ALL SELECT 355 UNION ALL SELECT 356 UNION ALL SELECT 357 UNION ALL SELECT 358 UNION ALL SELECT 359 UNION ALL SELECT 360 UNION ALL SELECT 361 UNION ALL SELECT 362 UNION ALL SELECT 363 UNION ALL SELECT 364 UNION ALL SELECT 365 UNION ALL SELECT 366 UNION ALL SELECT 367 UNION ALL SELECT 368 UNION ALL SELECT 369 UNION ALL SELECT 370 UNION ALL SELECT 371 UNION ALL SELECT 372 UNION ALL SELECT 373 UNION ALL SELECT 374 UNION ALL SELECT 375 UNION ALL SELECT 376 UNION ALL SELECT 377 UNION ALL SELECT 378 UNION ALL SELECT 379 UNION ALL SELECT 380 UNION ALL SELECT 381 UNION ALL SELECT 382 UNION ALL SELECT 383 UNION ALL SELECT 384 UNION ALL SELECT 385 UNION ALL SELECT 386 UNION ALL SELECT 387 UNION ALL SELECT 388 UNION ALL SELECT 389 UNION ALL SELECT 390 UNION ALL SELECT 391 UNION ALL SELECT 392 UNION ALL SELECT 393 UNION ALL SELECT 394 UNION ALL SELECT 395 UNION ALL SELECT 396 UNION ALL SELECT 397 UNION ALL SELECT 398 UNION ALL SELECT 399 UNION ALL SELECT 400 UNION ALL SELECT 401 UNION ALL SELECT 402 UNION ALL SELECT 403 UNION ALL SELECT 404 UNION ALL SELECT 405 UNION ALL SELECT 406 UNION ALL SELECT 407 UNION ALL SELECT 408 UNION ALL SELECT 409 UNION ALL SELECT 410 UNION ALL SELECT 411 UNION ALL SELECT 412 UNION ALL SELECT 413 UNION ALL SELECT 414 UNION ALL SELECT 415 UNION ALL SELECT 416 UNION ALL SELECT 417 UNION ALL SELECT 418 UNION ALL SELECT 419 UNION ALL SELECT 420 UNION ALL SELECT 421 UNION ALL SELECT 422 UNION ALL SELECT 423 UNION ALL SELECT 424 UNION ALL SELECT 425 UNION ALL SELECT 426 UNION ALL SELECT 427 UNION ALL SELECT 428 UNION ALL SELECT 429 UNION ALL SELECT 430 UNION ALL SELECT 431 UNION ALL SELECT 432 UNION ALL SELECT 433 UNION ALL SELECT 434 UNION ALL SELECT 435 UNION ALL SELECT 436 UNION ALL SELECT 437 UNION ALL SELECT 438 UNION ALL SELECT 439 UNION ALL SELECT 440 UNION ALL SELECT 441 UNION ALL SELECT 442 UNION ALL SELECT 443 UNION ALL SELECT 444 UNION ALL SELECT 445 UNION ALL SELECT 446 UNION ALL SELECT 447 UNION ALL SELECT 448 UNION ALL SELECT 449 UNION ALL SELECT 450 UNION ALL SELECT 451 UNION ALL SELECT 452 UNION ALL SELECT 453 UNION ALL SELECT 454 UNION ALL SELECT 455 UNION ALL SELECT 456 UNION ALL SELECT 457 UNION ALL SELECT 458 UNION ALL SELECT 459 UNION ALL SELECT 460 UNION ALL SELECT 461 UNION ALL SELECT 462 UNION ALL SELECT 463 UNION ALL SELECT 464 UNION ALL SELECT 465 UNION ALL SELECT 466 UNION ALL SELECT 467 UNION ALL SELECT 468 UNION ALL SELECT 469 UNION ALL SELECT 470 UNION ALL SELECT 471 UNION ALL SELECT 472 UNION ALL SELECT 473 UNION ALL SELECT 474 UNION ALL SELECT 475 UNION ALL SELECT 476 UNION ALL SELECT 477 UNION ALL SELECT 478 UNION ALL SELECT 479 UNION ALL SELECT 480 UNION ALL SELECT 481 UNION ALL SELECT 482 UNION ALL SELECT 483 UNION ALL SELECT 484 UNION ALL SELECT 485 UNION ALL SELECT 486 UNION ALL SELECT 487 UNION ALL SELECT 488 UNION ALL SELECT 489 UNION ALL SELECT 490 UNION ALL SELECT 491 UNION ALL SELECT 492 UNION ALL SELECT 493 UNION ALL SELECT 494 UNION ALL SELECT 495 UNION ALL SELECT 496 UNION ALL SELECT 497 UNION ALL SELECT 498 UNION ALL SELECT 499;
CREATE TABLE t3(a REAL);
INSERT INTO t3 VALUES(44.0);
INSERT INTO t3 VALUES(56.0);
pragma vdbe_trace = 0;
SELECT (CASE WHEN a=0 THEN 0 ELSE (a + 25) / 50 END) AS categ, count(*)
    FROM t3 GROUP BY categ;
CREATE TABLE t4(a REAL);
INSERT INTO t4 VALUES( 2.0 );
INSERT INTO t4 VALUES( 3.0 );
SELECT (CASE WHEN a=0 THEN 'zero' ELSE a/2 END) AS t FROM t4 GROUP BY t;
SELECT a=0, typeof(a) FROM t4;
CREATE TABLE t5(a TEXT, b INT);
INSERT INTO t5 VALUES(123, 456);
CREATE TABLE t01(x, y);
CREATE TABLE t02(x, y);
CREATE VIEW v0 as SELECT x, y FROM t01 UNION SELECT x FROM t02;
