CREATE TYPE RENTER_TYPE_ENUM AS ENUM ('PRIVATE', 'BUSINESS');

ALTER TABLE renter ADD COLUMN renter_type RENTER_TYPE_ENUM not null default 'PRIVATE';
ALTER TABLE renter ADD COLUMN chamber_of_commerce TEXT null default null;
ALTER TABLE renter ADD COLUMN vat_number TEXT null default null;
ALTER TABLE rental_item ADD COLUMN renter_type RENTER_TYPE_ENUM null default null;