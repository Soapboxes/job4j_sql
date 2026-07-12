SELECT id, name, price
	FROM products
	ORDER BY name;

SELECT id, name, priceK
	FROM products
	WHERE is_active = TRUE
	ORDER BY price ASC
	LIMIT 5;

SELECT id, user_id, status, created_at
	FROM orders
	ORDER BY id DESC
	LIMIT 10;

SELECT id, name, email
	FROM users
	ORDER BY created_at DESC, id DESC
	LIMIT 20 OFFSET 20;

SELECT id, order_id, product_id, quantity, unit_price
 	FROM order_items
	ORDER BY order_id, unit_price DESC, id ASC;

SELECT id, name, price
	FROM products
	ORDER BY price DESC, id ASC
	LIMIT 3 OFFSET 6;