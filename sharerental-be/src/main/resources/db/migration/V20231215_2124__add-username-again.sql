alter table usr add column username varchar(255);

update usr set username = split_part(email, '@', 1);

alter table usr alter column username set not null;