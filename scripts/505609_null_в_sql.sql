SELECT * FROM users;

ALTER TABLE users
ADD COLUMN phone TEXT NULL,
ADD COLUMN middle_name TEXT NULL;

SELECT * FROM users;

UPDATE users
	SET phone = '+79219990001', middle_name = 'Ivanovich'
	WHERE id = 1;

UPDATE users
	SET phone = '+79210000001'
	WHERE id = 2;

UPDATE users
	SET middle_name = 'Sergeevich'
	WHERE id = 3;

SELECT * FROM products;

ALTER TABLE products
ADD COLUMN description TEXT NULL,
ADD COLUMN discount_price NUMERIC(12, 2) NULL;

UPDATE products
SET discount_price = 999.90
WHERE id = 4;

UPDATE products
SET description = 'порвана коробка'
WHERE id = 4;

SELECT id, name, middle_name
	FROM users
	WHERE middle_name IS NULL;

SELECT id, name, description
	FROM products
	WHERE description IS NULL;

SELECT id, name, price, discount_price
	FROM products
	WHERE discount_price IS NULL;

SELECT id, name, phone
	FROM users
	WHERE phone IS NULL
	OR phone = '';

SELECT id, name, COALESCE(description, 'описание отсутствует') AS display_description
	FROM products;

SELECT id, name, price, discount_price, COALESCE(discount_price, price) AS final_price
	FROM products;