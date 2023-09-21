
alter table rental_item add column slug text not null unique default gen_random_uuid();