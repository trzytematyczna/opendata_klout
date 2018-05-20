
CREATE DATABASE pinterest
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


create table if not exists repins(
    user_id int DEFAULT NULL,
    post_id int NOT NULL,
    actor_id int NOT NULL
  );

create table if not exists likes(
    user_id int DEFAULT NULL,
    post_id int NOT NULL,
    actor_id int NOT NULL
  );

COPY repins(actor_id,post_id, user_id) FROM  '/Users/admin/Desktop/data/pinterest/repins.csv' DELIMITER '|' CSV HEADER;
COPY likes(actor_id,post_id, user_id) FROM  '/Users/admin/Desktop/data/pinterest/likes.csv' DELIMITER '|' CSV HEADER;


#for tenlink in `ls /usr/local/bin | grep '../Library/Frameworks/Python.framework/Versions/3.5'`; do instrukcja $tenlink; done


create index index_repins_uid on repins(user_id);
create index index_repins_aid on repins(actor_id);
create index index_likes_uid on likes(user_id);
create index index_likes_aid on likes(actor_id);
