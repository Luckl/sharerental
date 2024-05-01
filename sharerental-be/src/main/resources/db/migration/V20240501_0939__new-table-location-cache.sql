create table postal_code_location (
    created_at timestamp default current_timestamp,
    postal_code varchar(10) not null,
    house_number varchar(10) not null,
    latitude numeric not null,
    longitude numeric not null,
    primary key (postal_code, house_number)
)