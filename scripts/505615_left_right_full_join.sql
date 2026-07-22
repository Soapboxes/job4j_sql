SELECT
	u.id   		  AS user_id,
	u.name 		  AS user_name,
	COUNT(o.id)   AS order_id
FROM users    	  AS u
LEFT JOIN orders  AS o ON o.user_id = u.id
GROUP BY u.id, u.name;

SELECT
	o.id 		  AS order_id,
	o.status      AS order_status,
	o.created_at
FROM orders  	  AS o
LEFT JOIN  payments AS p ON p.order_id = o.id
WHERE p.order_id IS NULL;

SELECT
	p.id 		  AS product_id,
	p.name 		  AS product_name,
	COUNT(oi.id)  AS order_count
FROM order_items  AS oi
LEFT JOIN products AS p ON oi.product_id = p.id
GROUP BY p.id, p.name;

SELECT
	r.id 		  AS roles_id,
	r.code,
	COUNT(ur.user_id)
FROM roles        AS r
LEFT JOIN user_roles  AS ur ON  ur.role_id = r.id
GROUP BY r.id, r.code
ORDER BY r.code;

SELECT
    u.id    	 AS user_id,
    u.name 		 AS user_name,
    ur.role_id
FROM users       AS u
LEFT JOIN user_roles ur ON ur.user_id = u.id
WHERE ur.role_id IS NULL;

SELECT
    r.id   		 AS role_id,
    r.code,
    ur.user_id
FROM roles 		 AS r
FULL JOIN user_roles AS ur ON ur.role_id = r.id;

SELECT
	 r.id    	 AS role_code,
	 e.code      AS environment_code
FROM roles       AS r
CROSS JOIN environments AS e;

SELECT
	c.id,
	c.name       AS category_name,
	p.name       AS parent_category
FROM categories  AS c
LEFT JOIN categories AS p ON c.parent_id = p.id
ORDER BY c.id;
