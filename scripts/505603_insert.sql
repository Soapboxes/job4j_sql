insert into users (name, email)
values ('Ivan Petrov', 'ivan.petrov@example.com')
returning *;

insert into users (name, email)
values
    ('Anna Smirnova', 'anna.smirnova@example.com'),
    ('Petr Ivanov', 'petr.ivanov@example.com'),
    ('Olga Sidorova', 'olga.sidorova@example.com')
returning id, name, email;

select id, name, email, created_at
from users
order by id;

insert into products (name, price, is_active)
values
    ('iPhone 17', 99990.00, true),
    ('MacBook Air M5', 149990.00, true),
    ('AirPods Pro 2', 24990.00, true),
    ('Old Keyboard', 1500.00, false)
returning id, name, price, is_active;

insert into orders (user_id, status)
values
    (1, 'NEW'),
    (2, 'PAID')
returning id, user_id, status, created_at;

select id, name
from users
order by id;

insert into order_items (order_id, product_id, quantity, unit_price)
values
	(1,1,1, 99990.00),
	(1,3,2, 24990.00),
	(2,2,1, 149990.00)
	returning *;

select
    o.id as order_id,
    u.name as user_name,
    p.name as product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price as line_total,
    o.status,
    o.created_at
from orders o
         join users u on u.id = o.user_id
         join order_items oi on oi.order_id = o.id
         join products p on p.id = oi.product_id
order by o.id, oi.id;

drop TABLE IF EXISTS inactive_products_archive;

create table inactive_products_archive
(
    id           bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id   BIGINT         NOT NULL,
    product_name TEXT           NOT NULL,
    price        NUMERIC(12, 2) NOT NULL,
    archived_at  TIMESTAMPTZ    NOT NULL DEFAULT now()
);

insert into inactive_products_archive (product_id, product_name, price)
select id, name, price
from products
where is_active = false;

select * from inactive_products_archive;