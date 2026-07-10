create table roles (
    id int generated always as identity primary key,
    name_role TEXT not null unique,
    created_at  TIMESTAMPTZ not null default NOW()
    );

create table users (
    id BIGINT generated always as identity primary key,
    email       TEXT not null unique,
    password_hash TEXT not null,
    role_id     int not null references roles (id),
    created_at  TIMESTAMPTZ not null default NOW()
    );

create table states (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    is_active   BOOLEAN NOT NULL DEFAULT true,
    created_at  TIMESTAMPTZ not null default NOW()
    );

create table categories (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_categories TEXT NOT NULL UNIQUE,
    created_at  TIMESTAMPTZ not null default NOW()
    );

create table items (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id     BIGINT NOT NULL REFERENCES users (id),
    name_item TEXT   NOT NULL UNIQUE,
    description_item TEXT NOT NULL,
    item_categories BIGINT NOT NULL REFERENCES categories (id),
    item_states     BIGINT NOT NULL REFERENCES states (id),
    created_at  TIMESTAMPTZ not null default NOW()
    );

create table comments (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    text_comment TEXT NOT NULL,
    user_id     BIGINT NOT NULL REFERENCES users (id),
    item_id     BIGINT NOT NULL REFERENCES items (id),
    created_at  TIMESTAMPTZ not null default NOW()
    );