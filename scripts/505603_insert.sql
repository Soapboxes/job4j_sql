insert into users (name, email)
values ('Ivan Petrov', 'ivan.petrov@example.com')
returning *;

insert into users (name, email)
values
    ('Anna Smirnova', 'anna.smirnova@example.com'),
    ('Petr Ivanov', 'petr.ivanov@example.com'),
    ('Olga Sidorova', 'olga.sidorova@example.com')
RETURNING id, name, email;

select id, name, email, created_at
from users
order by id;

insert into products (name, price, is_active)
values
    ('iPhone 17', 99990.00, true),
    ('MacBook Air M5', 149990.00, true),
    ('AirPods Pro 2', 24990.00, true),
    ('Old Keyboard', 1500.00, false)
RETURNING id, name, price, is_active;

insert into orders (user_id, status)
values
    (1, 'NEW'),
    (2, 'PAID')
RETURNING id, user_id, status, created_at;

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

drop table IF EXISTS inactive_products_archive;

create table inactive_products_archive
(
    id           BIGINT generated always as identity primary key,
    product_id   BIGINT         not null,
    product_name TEXT           not null,
    price        numeric(12, 2) not null,
    archived_at  TIMESTAMPTZ    not null default now()
);