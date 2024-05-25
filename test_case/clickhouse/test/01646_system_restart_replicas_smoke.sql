-- Tag no-tsan: RESTART REPLICAS can acquire too much locks, while only 64 is possible from one thread under TSan

DROP TABLE IF EXISTS data_01646;
SYSTEM RESTART REPLICAS;
