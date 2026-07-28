SELECT
	user_id
FROM
	orders o
WHERE
	o.status = 'PAID'
UNION
	SELECT
	user_id
FROM
	orders o
WHERE
	o.status = 'NEW'
ORDER BY
	user_id;

SELECT
	'user' AS entity_type,
	u.id AS entity_id,
	created_at
FROM
	users u
UNION ALL
SELECT
	'product' AS entity_type,
	p.id AS entity_id,
	created_at
FROM
	products p
UNION ALL
SELECT
	'order' AS entity_type,
	o.id AS entity_id,
	created_at
FROM
	orders o
ORDER BY
	created_at DESC;

SELECT
	id AS product_id,
	name AS product_name
FROM
	products
WHERE
	is_active = TRUE
INTERSECT
	SELECT
	p.id AS product_id,
	p.name AS product_name
FROM
	products p
JOIN order_items oi ON
	oi.product_id = p.id
ORDER BY
	product_id,
	product_name;

SELECT
	p.id AS product_id,
	p.name AS product_name
FROM
	products p
WHERE
	p.is_active = TRUE
EXCEPT
SELECT
	p.id AS product_id,
	p.name AS product_name
FROM
	products p
JOIN order_items oi ON
	oi.product_id = p.id
ORDER BY
	product_id,
	product_name;

SELECT
	u.id AS user_id,
	u.name AS user_name
FROM
	users u
WHERE
	EXISTS (
		SELECT
			1
		FROM
			orders AS o
		WHERE
			o.user_id = u.id
	)
UNION
    SELECT
	u.id AS user_id,
	u.name AS user_name
FROM
	users u
WHERE
	u.created_at >= DATE '2025-01-01'
ORDER BY
	user_id,
	user_name;

SELECT
	p.id AS product_id,
	p.name AS product_name,
	p.price
FROM
	products p
WHERE
	EXISTS (
		SELECT
			1
		FROM
			order_items oi
		WHERE
			oi.product_id = p.id
	)
INTERSECT
	SELECT
	p.id AS product_id,
	p.name AS product_name,
	p.price
FROM
	order_items oi
JOIN products p ON
	oi.product_id = p.id
WHERE
	p.price > (
		SELECT
			AVG(price)
		FROM
			products
	)
ORDER BY
	product_id,
	product_name,
	price;

SELECT
	u.id AS user_id,
	u.name AS user_name
FROM
	users u
WHERE
	EXISTS (
		SELECT
			1
		FROM
			orders o
		WHERE
			o.user_id = u.id
	)
EXCEPT
	SELECT
	u.id AS user_id,
	u.name AS user_name
FROM
	users u
JOIN orders o ON
	u.id = o.user_id
WHERE
	o.status = 'CANCELLED'
ORDER  BY
	user_id,
	user_name;

SELECT
	'user' AS entity_type,
	u.id AS entity_id,
	u.name AS display_name
FROM
	users u
UNION ALL
	SELECT
	'product' AS entity_type,
	p.id AS entity_id,
	p.name AS display_name
FROM
	products p
ORDER BY
	entity_type,
	entity_id,
	display_name;
