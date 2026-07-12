SELECT id, name, price, is_active
	FROM products
	WHERE is_active = TRUE;

SELECT id, user_id, status, created_at
	FROM orders
	WHERE status IN ('NEW', 'PAID');

INSERT INTO orders (user_id, status)
VALUES 	(1, 'CANCELLED'),
    	(1, 'CANCELLED'),
    	(1, 'CANCELLED')
RETURNING id, user_id, status;

SELECT id, user_id, status, created_at
	FROM orders
	WHERE status <> 'CANCELLED';

SELECT id, name, email, created_at
	FROM users
	WHERE created_at BETWEEN
      	  TIMESTAMPTZ '2026-01-01 00:00:00+00'
  	AND   TIMESTAMPTZ '2026-12-31 23:59:59+00';

SELECT id, name, price
	FROM products
	WHERE price < 20000 OR price > 80000;

SELECT id, name, price
	FROM products
	WHERE is_active = TRUE
	AND (price <= 3000 OR price >= 150000);


