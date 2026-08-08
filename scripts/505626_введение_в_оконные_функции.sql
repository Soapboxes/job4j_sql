SELECT
	o.id AS order_id,
	o.user_id,
	SUM(oi.quantity * oi.unit_price) AS total_amount,
	SUM(SUM(oi.quantity * oi.unit_price)) OVER (
		PARTITION BY o.user_id
	) AS user_total
FROM
	orders o
JOIN order_items oi ON
	oi.order_id = o.id
GROUP BY
	o.id,
	o.user_id
ORDER BY
	o.user_id,
	o.id;

SELECT
	o.id AS order_id,
	o.user_id,
	SUM(oi.quantity * oi.unit_price) AS total_amount,
	AVG(SUM(oi.quantity * oi.unit_price)) OVER (
		PARTITION BY o.user_id
	) AS average_order_amount
FROM
	orders o
JOIN order_items oi ON
	oi.order_id = o.id
GROUP BY
	o.id,
	o.user_id
ORDER BY
	o.user_id,
	o.id;

SELECT
	o.id AS order_id,
	o.user_id,
	created_at,
	row_number() OVER (
	PARTITION BY o.user_id  ORDER BY o.created_at
	) AS row_number
FROM
	orders o
ORDER BY
	o.user_id,
	o.id;

SELECT
	o.id AS order_id,
	SUM(oi.quantity * oi.unit_price) AS total_amount,
	RANK() OVER (
	ORDER BY
		SUM(oi.quantity * oi.unit_price) DESC
	)
		 AS order_rank
FROM
	orders o
JOIN order_items oi ON
	oi.order_id = o.id
GROUP BY
	o.id;

SELECT
	o.id AS order_id,
	SUM(oi.quantity * oi.unit_price) AS total_amount,
	DENSE_RANK() OVER (
	ORDER BY
		SUM(oi.quantity * oi.unit_price) DESC ) AS order_rank
	FROM
		orders o
	JOIN order_items oi ON
		oi.order_id = o.id
	GROUP BY
		o.id;
--разница в присвоении порядкового номера(ранга) dense - ранги без пропуска ( знач1 = ранг1.)
--просто ранг оставляет пропуски № рангов

SELECT
	o.id AS order_id,
	SUM(oi.quantity * oi.unit_price) AS total_amount,
	NTILE(4) OVER (
	ORDER BY
			SUM(oi.quantity * oi.unit_price) DESC
	) AS group_number
FROM
	orders o
JOIN order_items oi ON
	o.id = oi.order_id
GROUP BY
	o.id;

SELECT
	o.id AS order_id,
	u.id AS user_id,
	SUM(oi.quantity * oi.unit_price) AS total_amount,
	SUM(SUM(oi.quantity * oi.unit_price)) OVER w AS user_total,
	AVG(SUM(oi.quantity * oi.unit_price)) OVER w AS average_order_amount,
	COUNT(*) OVER w AS orders_count
FROM
	orders o
JOIN order_items oi ON
	oi.order_id = o.id
JOIN users u ON
	o.user_id = u.id
GROUP BY
	o.id,
	u.id
WINDOW w AS (
		PARTITION BY user_id
	);
