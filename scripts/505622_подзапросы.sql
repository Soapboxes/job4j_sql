SELECT
	p.id AS product_id,
	p.name AS product_name,
	p.price
FROM
	products p
WHERE
	price < (
		SELECT
			AVG(price)
		FROM
			products
	)
	ORDER BY product_id;

SELECT
	u.id AS user_id,
	u.name AS user_name,
	email
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
			AND status = 'PAID'
	)
ORDER BY
	user_id;

SELECT
	u.id AS user_id,
	u.name AS user_name,
	email
FROM
	users u
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			orders o
		WHERE
			o.user_id = u.id
	)
ORDER BY
	user_id;

SELECT
	p.id AS product_id,
	p.name AS product_name,
	price
FROM
	products p
WHERE
	id IN (
		SELECT
			product_id
		FROM
			order_items oi
	)
ORDER BY
	product_id;

SELECT
	order_id,
	order_total
FROM
	(
		SELECT
			oi.order_id,
			SUM(oi.quantity * oi.unit_price) AS order_total
		FROM
			order_items oi
		GROUP BY
			oi.order_id
	) AS t
WHERE
	order_total >10000
ORDER BY
	order_total;

SELECT
	u.id AS user_id,
	u.name AS user_name,
	(
		SELECT
			COUNT(*)
		FROM
			orders o
		WHERE
			o.user_id = u.id
	) AS orders_count
FROM
	users u
ORDER BY
	user_id;

SELECT
	product_id,
	SUM(quantity) AS total_quantity
FROM
	order_items oi
GROUP BY
	product_id
HAVING
	SUM(quantity) > (
		SELECT
			AVG(total_quantity)
		FROM
			(
				SELECT
					product_id,
					SUM(quantity) AS total_quantity
				FROM
					order_items oi
				GROUP BY
					product_id
			) AS product_total
	)
ORDER BY
	product_id;

SELECT
	order_id,
	order_total
FROM
	(
		SELECT
			oi.order_id,
			SUM(oi.quantity * oi.unit_price) AS order_total
		FROM
			order_items oi
		GROUP BY
			oi.order_id
	) AS t
WHERE
	t.order_total > (
		SELECT
			AVG(order_total)
		FROM
			(
				SELECT
					oi.order_id,
					SUM(oi.quantity * oi.unit_price) AS order_total
				FROM
					order_items oi
				GROUP BY
					oi.order_id
			) AS order_totals
	);