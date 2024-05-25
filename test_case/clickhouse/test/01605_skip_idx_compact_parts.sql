SYSTEM STOP MERGES skip_idx_comp_parts;
INSERT INTO skip_idx_comp_parts SELECT number, number FROM numbers(200);
INSERT INTO skip_idx_comp_parts SELECT number, number FROM numbers(200);
INSERT INTO skip_idx_comp_parts SELECT number, number FROM numbers(200);
INSERT INTO skip_idx_comp_parts SELECT number, number FROM numbers(200);
SYSTEM START MERGES skip_idx_comp_parts;
OPTIMIZE TABLE skip_idx_comp_parts FINAL;
SELECT count() FROM skip_idx_comp_parts WHERE b > 100;
DROP TABLE skip_idx_comp_parts;
