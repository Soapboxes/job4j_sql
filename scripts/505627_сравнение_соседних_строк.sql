INSERT INTO orders (user_id, status, created_at) VALUES
(1, 'COMPLETED', '2026-07-15 10:00:00'),
( 2, 'COMPLETED', '2026-07-15 14:30:00'),
( 3, 'COMPLETED', '2026-07-18 09:15:00'),
( 1, 'COMPLETED', '2026-07-18 16:45:00'),
( 1, 'COMPLETED',  now()),
( 2, 'COMPLETED', now()),
( 3, 'COMPLETED', now());

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(23, 1, 2, 99900.00),
(23, 3, 1, 149900.00),
(24, 2, 3, 1500.00);

WITH daily_sales AS (
	SELECT
		DATE(o.created_at) AS sale_date,
		SUM(oi.quantity * oi.unit_price) AS sales_amount
	FROM
		orders o
	JOIN order_items oi
    ON
		oi.order_id = o.id
	GROUP BY
		DATE(o.created_at)
)
	SELECT
		sale_date,
		sales_amount,
		LAG(sales_amount) OVER (
	ORDER BY
			sale_date
	) AS previous_day_sales,
		LEAD(sales_amount) OVER (
	ORDER BY
			sale_date
	) AS next_day_sales,
		LEAD(sales_amount) OVER (
	ORDER BY
			sale_date
	) - sales_amount AS sales_diff,
		SUM(sales_amount) OVER (
	ORDER BY
			sale_date
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	)
 AS running_total,
		ROUND(
        AVG(sales_amount) OVER (
            ORDER BY sale_date
            ROWS BETWEEN 2 PRECEDING
                     AND CURRENT ROW
        ),
        2
    ) AS avg_last_three_days
FROM
	daily_sales
ORDER BY
	sale_date;