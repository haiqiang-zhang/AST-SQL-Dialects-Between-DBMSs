PRAGMA enable_verification;
CREATE TABLE tag(id int, name string, subclassof int);;
INSERT INTO tag VALUES
  (7, 'Music',  9),
  (8, 'Movies', 9),
  (9, 'Art',    NULL)
;;
WITH RECURSIVE tag_hierarchy(id, source, path, target) AS (
  SELECT id, name, name AS path, NULL AS target -- this should be '' for correct behaviour
  FROM tag
  WHERE subclassof IS NULL
  UNION ALL
  SELECT tag.id, tag.name, tag_hierarchy.path || ' <- ' || tag.name, tag.name AS target
  FROM tag, tag_hierarchy
  WHERE tag.subclassof = tag_hierarchy.id
)
SELECT source, path, target
FROM tag_hierarchy
;;
