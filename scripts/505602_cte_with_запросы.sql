WITH total_line AS (
	SELECT
		order_id,
		quantity * unit_price AS line_total
	FROM
		order_items oi
	JOIN orders o ON
		oi.order_id = o.id
),
order_totals AS (
	SELECT
		order_id,
		SUM(line_total) AS total_amount
	FROM
		total_line
	GROUP BY
		order_id
)
SELECT
	order_id,
	total_amount
FROM
	order_totals
ORDER BY
	order_id;

WITH user_totals AS (
	SELECT
		o.user_id,
		SUM(oi.quantity * oi.unit_price) AS ttl_amount
	FROM
		orders o
	JOIN order_items oi ON
		o.id = oi.order_id
	WHERE
		o.status = 'PAID'
	GROUP BY
		o.user_id
),
average_ttl AS (
	SELECT
		AVG(ttl_amount) AS avg_ttls
	FROM
		user_totals
)
SELECT
	u.id AS user_id,
	u.name AS user_name,
	ut.ttl_amount
FROM
	users u
JOIN user_totals ut ON
	ut.user_id = u.id
CROSS JOIN average_ttl at
WHERE
	ut.ttl_amount > at.avg_ttls;

WITH order_products AS (
	SELECT
	p.id AS product_id
	FROM products p
	LEFT JOIN order_items oi ON oi.product_id = p.id
	WHERE oi.product_id IS NULL
)
 SELECT
	p.id AS product_id,
	p.name AS product_name
	FROM products p
	JOIN order_products op ON op.product_id = p.id;

WITH total_quantity AS (
	SELECT
		product_id,
		SUM(quantity) AS ttl_quantity
	FROM
		order_items oi
	GROUP BY
		product_id
)
SELECT
	product_id,
	p.name AS product_name,
	ttl_quantity AS total_quantity
FROM
	products p
JOIN total_quantity tq ON
	tq.product_id = p.id
GROUP BY
	product_id,
	product_name,
	total_quantity
ORDER BY
	total_quantity DESC
LIMIT 5;
