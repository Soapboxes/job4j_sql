CREATE TABLE folders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    parent_id BIGINT REFERENCES folders(id)
);

INSERT INTO folders (id, name, parent_id)  OVERRIDING SYSTEM VALUE
VALUES (1, 'Projects', NULL),
       (2, 'Backend', 1),
       (3, 'Frontend', 1),
       (4, 'Java', 2),
       (5, 'Python', 2),
       (6, 'src', 4),
       (7, 'test', 4),
       (8, 'React', 3),
       (9, 'components', 8),
       (10, 'utils', 9),
       (11, 'images', 8);

UPDATE folders
SET parent_id = 10
WHERE id = 3;

SELECT * FROM folders ORDER BY id;

WITH RECURSIVE org_tree AS (
	SELECT
		id,
		name,
		parent_id,
		1 AS LEVEL,
		name::text AS tree_path
	FROM
		folders
	WHERE
		id = 1
UNION ALL
	SELECT
		f.id,
		f.name AS folder_name,
		f.parent_id,
		ot.LEVEL + 1,
		ot.tree_path || ' -> ' || f.name
	FROM
		folders f
	JOIN org_tree ot ON
		f.parent_id = ot.id
)
SELECT
	repeat('    -', LEVEL - 1) || name AS folder_name,
	parent_id,
	LEVEL
FROM
	org_tree
ORDER BY
	tree_path;

SELECT id, name, parent_id FROM folders ORDER BY id;

WITH RECURSIVE breadcrumb AS (
    SELECT
        id,
        name,
        parent_id,
        ARRAY[name]::text[] AS path
    FROM
        folders
    WHERE
        id = 10
    UNION ALL
    SELECT
	f.id,
	f.name,
	f.parent_id,
	ARRAY[f.name]::text[] || b.path
FROM
	folders f
JOIN breadcrumb b ON
	f.id = b.parent_id
)
SELECT
	array_to_string(PATH, ' -> ') AS full_path
FROM
	breadcrumb
WHERE
	parent_id IS NULL;

WITH RECURSIVE org_tree AS (
    SELECT
        id,
        name,
        parent_id,
        1 AS LEVEL,
        name::text AS tree_path
    FROM
        folders
    WHERE
        id = 1
    UNION ALL
    SELECT
	f.id,
	f.name,
	f.parent_id,
	ot.LEVEL + 1,
	ot.tree_path || ' -> ' || f.name
FROM
	folders f
JOIN org_tree ot ON
	f.parent_id = ot.id
)
CYCLE id SET
	is_cycle
		USING cycle_path
SELECT
	repeat('    -', LEVEL - 1) || name AS folder_name,
	LEVEL
FROM
	org_tree
WHERE
	NOT is_cycle
ORDER BY
	tree_path;