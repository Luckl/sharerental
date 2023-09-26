
alter table transaction
    add mollie_payment_reference text not null default 'unknown';
