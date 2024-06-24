alter table location
    add column latitude numeric,
    add column longitude numeric;

alter table location
    drop column geo_location;