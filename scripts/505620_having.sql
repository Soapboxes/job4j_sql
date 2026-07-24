SELECT
	o.status,
	COUNT(*) AS orders_count
FROM
	orders AS o
GROUP BY
	status
HAVING
	COUNT(*) >= 3
ORDER BY
	orders_count;

SELECT
	u.id AS user_id,
	u.name AS user_name,
	SUM(quantity * unit_price) AS total_spent
FROM
	users AS u
LEFT JOIN orders AS o ON
	o.user_id = u.id
LEFT JOIN order_items AS oi ON
	oi.order_id = o.id
GROUP BY
	u.id,
	u.name
HAVING
	SUM(oi.quantity * oi.unit_price) > 10000
ORDER BY
	u.id;

SELECT
	p.id AS product_id,
	p.name AS product_name,
	COUNT(quantity)  AS total_quantity
FROM
	order_items oi
LEFT JOIN products p ON
	oi.product_id = p.id
WHERE oi.unit_price >= 1000
GROUP BY
	p.id,
	p.name
HAVING SUM
	(oi.quantity ) >= 5
ORDER BY
	p.id;

SELECT
	u.id AS user_id,
	u.name AS user_name,
	o.status,
	COUNT(o.id) AS orders_count
FROM
	users AS u
LEFT JOIN orders AS o ON
	o.user_id = u.id
GROUP BY
	u.id,
	u.name,
	status
	HAVING COUNT(o.id) > 1
ORDER BY
	u.id;

SELECT
	o.id AS order_id,
	SUM(oi.quantity) AS total_quantity
FROM
	orders o
LEFT JOIN order_items oi ON
	oi.order_id = o.id
GROUP BY
	o.id
HAVING
	SUM(oi.quantity) >= 4
ORDER BY
	o.id;

SELECT
	u.id AS user_id,
	u.name AS user_name,
	COUNT(o.id) AS paid_orders_count
FROM
	users u
LEFT JOIN orders o ON
	o.user_id = u.id
WHERE
	status = 'PAID'
GROUP BY
	u.id
HAVING
	COUNT(*) >= 2
ORDER BY
	u.id;

SELECT
	p.id AS product_id,
	p.name AS product_name,
	MIN(unit_price) AS min_unit_price,
	MAX(unit_price) AS max_unit_price
FROM
	order_items oi
LEFT JOIN products p ON
	oi.product_id = p.id
GROUP BY
	p.id,
	p.name
HAVING
	max(unit_price) > 5000
ORDER BY
	p.id;

SELECT
	status,
	AVG(oi.quantity * oi.unit_price) AS avg_line_total
FROM
	orders o
INNER JOIN order_items oi ON
	oi.order_id = o.id
WHERE
	o.created_at >= DATE '2025-01-01'
GROUP BY
	o.status
HAVING
	AVG(oi.quantity * oi.unit_price) > 2000
ORDER BY
	o.status;

