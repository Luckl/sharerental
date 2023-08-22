CREATE TYPE FUEL_TYPE_ENUM AS ENUM ('GASOLINE', 'PETROL', 'ELECTRIC');
CREATE TABLE rental_item (
                             id BIGINT PRIMARY KEY,
                             name TEXT NOT NULL,
                             number TEXT,
                             short_description TEXT,
                             long_description TEXT,
                             price_24h NUMERIC,
                             price_48h NUMERIC,
                             price_168h NUMERIC,
                             delivery_possible BOOLEAN,
                             delivery_price NUMERIC,
                             category TEXT,
                             reach_meters NUMERIC,
                             carrying_weight_kilograms NUMERIC,
                             maximum_work_height_meters NUMERIC,
                             intrinsic_weight_kilograms NUMERIC,
                             material_type TEXT,
                             brand TEXT,
                             maximum_pressure_bars NUMERIC,
                             maximum_horse_power NUMERIC,
                             required_power_voltage_volt NUMERIC,
                             work_width_meters NUMERIC,
                             vacuum_attachment_possible BOOLEAN,
                             capacity_liters NUMERIC,
                             item_height NUMERIC,
                             item_width NUMERIC,
                             item_length NUMERIC,
                             power_watt NUMERIC,
                             maximum_surface_square_meters NUMERIC,
                             fuel_type FUEL_TYPE_ENUM
);

create table image (
                       id BIGINT PRIMARY KEY,
                       image_url TEXT NOT NULL
);

create table rental_item_image (
    image_id BIGINT,
    rental_item_id BIGINT,
    PRIMARY KEY (rental_item_id, image_id),
    FOREIGN KEY (rental_item_id) REFERENCES rental_item(id),
    FOREIGN KEY (image_id) REFERENCES image(id)
);
