alter table rental_item
    rename column renter_type to rent_to_renter_type;

ALTER TABLE renter ADD COLUMN company_name TEXT null default null;
