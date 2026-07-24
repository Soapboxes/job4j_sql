SELECT
    status,
    COUNT(*) AS orders_count
FROM orders
GROUP BY status
ORDER BY orders_count;

SELECT
	u.id AS user_id,
	u.name AS user_name,
	SUM(quantity * unit_price) AS total_spent
FROM
	users AS u
LEFT JOIN orders AS o ON
	o.user_id = u.id
LEFT JOIN order_items oi ON
	oi.order_id = o.id
GROUP BY
	u.id,
	u.name
ORDER BY
	total_spent;

SELECT
	p.id AS product_id,
	p.name AS product_name,
	COUNT(oi.id) AS order_items_count,
	SUM(quantity) AS total_quntity
FROM
	order_items oi
LEFT JOIN products p ON
	oi.product_id = p.id
GROUP BY
	p.id,
	p.name
ORDER BY
	p.id;

SELECT
	o.id AS order_id,
	COUNT(oi.id) AS items_count,
	SUM(oi.quantity * oi.unit_price) AS order_total
FROM
	orders o
INNER  JOIN order_items oi ON
	oi.order_id = o.id
GROUP BY
	o.id
ORDER BY
	o.id;

SELECT
	u.id AS user_id,
	u.name AS user_name,
	o.status,
	COUNT(o.id) AS orders_count
FROM
	users AS u
INNER JOIN orders AS o ON
	o.user_id = u.id
GROUP BY
	u.id,
	u.name,
	status
ORDER BY
	u.id;

SELECT
	p.id AS product_id,
	p.name AS product_name,
	MIN(unit_price) AS min_unit_price,
	MAX(unit_price) AS max_unit_price,
	AVG(unit_price) AS avg_unit_price
FROM
	order_items oi
INNER JOIN products p ON
	oi.product_id = p.id
GROUP BY
	p.id,
	p.name
ORDER BY
	p.id;

SELECT
	u.id AS user_id,
	u.name AS user_name,
	COUNT(o.id) AS orders_count
FROM
	users AS u
LEFT JOIN orders o ON
	o.user_id = u.id
GROUP BY
	u.id,
	u.name
ORDER BY
	u.id;