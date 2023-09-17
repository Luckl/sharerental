CREATE TYPE LESSOR_STATUS AS ENUM ('ACTIVE', 'INACTIVE');
CREATE TYPE RENTAL_ITEM_DISPLAY_STATUS AS ENUM ('INACTIVE', 'ACTIVE');

alter table lessor add column status LESSOR_STATUS not null default 'ACTIVE';
alter table rental_item add column display_status RENTAL_ITEM_DISPLAY_STATUS not null default 'ACTIVE';