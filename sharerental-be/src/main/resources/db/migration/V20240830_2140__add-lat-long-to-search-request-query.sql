alter table search_request_query
    add column latitude numeric,
    add column longitude numeric,
    add column zip_code text,
    add column country text;