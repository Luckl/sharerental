
alter table transaction_status
    rename createdTimestamp to created_timestamp;

alter table transaction
    rename renter to renter_id;

alter table transaction alter column current_status_id drop not null;

