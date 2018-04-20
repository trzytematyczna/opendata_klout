
CREATE DATABASE opendata_klout
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


create table if not exists fb(
    user_id bigint NOT NULL,
    actor_id bigint NOT NULL,
    post_id bigint DEFAULT NULL,
    post_timestamp integer DEFAULT NULL,
    action_timestamp integer DEFAULT NULL,
    user_timezone varchar(200) DEFAULT NULL,
    day_date DATE DEFAULT NULL
  );

#for tenlink in `ls /usr/local/bin | grep '../Library/Frameworks/Python.framework/Versions/3.5'`; do instrukcja $tenlink; done



f