CREATE TABLE vacancies
(
	id 		BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	title 	TEXT NOT NULL,
	company TEXT NOT NULL,
	description TEXT,
	created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO vacancies (title, company, description)
VALUES
('Senior JAVA/GO', 'Зряндекс', 'разработка высоконагруженных микросервисов. JAVA, GO'),
('QA тестировщик', 'Sber', 'тестрование веб приложений и баз PostgresSQL'),
('Стажер разработчик', 'Job4J', 'Работа по java, go и postgres.');

INSERT INTO users (name, email, phone, middle_name)
VALUES
('Марк Аврелий', 'marcus@gmail.com', NULL, 'Антонин');

INSERT INTO users (name, email, phone, middle_name)
VALUES
('Гай Цезарь', 'caesar@mail.com', NULL, NULL);

SELECT id, name, email
	FROM  users
	WHERE email LIKE '%mail%';

SELECT id, name, price
	FROM products
	WHERE name ILIKE '%air%';

SELECT id, name, price
	FROM  products
	WHERE name LIKE 'i%';

SELECT id, name, price
	FROM  products
	WHERE name LIKE '%pro';

SELECT id, name, email
	FROM users
	WHERE name ILIKE 'A%'
	OR    name ILIKE 'I%';

SELECT  id, title, company, description
	FROM vacancies
	WHERE title ILIKE '%java%'     OR 	  description ILIKE '%java%'
	OR    title ILIKE '%go%'       OR 	  description ILIKE '%go%'
	OR    title ILIKE '%postgres%' OR     description ILIKE '%postgres%';

SELECT id, name, price
	FROM products
	WHERE name ~ 'iPhone [0-9]+$';