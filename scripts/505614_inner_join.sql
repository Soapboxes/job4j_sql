SELECT
	o.id,
	o.status,
	u.email
FROM orders AS o
	INNER JOIN users AS u ON o.user_id = u.id
	ORDER BY o.id;

SELECT
	oi.id AS order_item_id,
	oi.order_id,
	p.name AS product_name,
	oi.quantity
FROM order_items AS oi
	INNER JOIN products AS p ON oi.product_id = p.id
	WHERE oi.quantity > 1
	ORDER BY oi.id;

SELECT
	oi.id AS order_id,
	p.name AS product_name,
	oi.quantity,
	oi.unit_price
FROM orders AS o
	INNER JOIN users AS u ON o.user_id = u.id
	INNER JOIN order_items AS oi ON oi.order_id = o.id
	INNER JOIN products AS p ON oi.product_id = p.id
	WHERE u.id = 1;

SELECT
	o.id AS order_id,
	o.status,
	u.name AS user_name
FROM orders AS o
	INNER JOIN users AS u ON o.user_id = u.id
	WHERE o.status = 'NEW';

SELECT
	oi.id AS order_item_id,
	p.name AS product_name,
	oi.quantity,
	quantity * unit_price AS line_total
FROM orders AS o
	INNER JOIN order_items AS oi ON oi.order_id = o.id
	INNER JOIN products AS p ON oi.product_id = p.id;
