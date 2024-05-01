create table postal_code_location (
    created_at timestamp default current_timestamp,
    content jsonb not null,
    postal_code varchar(10) not null,
    house_number varchar(10) not null,
    primary key (postal_code, house_number)
)