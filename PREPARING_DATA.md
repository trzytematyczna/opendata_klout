

1. Creating the db + table fb
create_database_openddadta_klouts.sql
2. Bash script load_data.sh

```sql
COPY fb(user_id,actor_id,post_id,post_timestamp,action_timestamp) TO '/Users/admin/Desktop/fb.csv' DELIMITER ',' CSV HEADER;

```

      user_id       |       actor_id       |       post_id       | post_timestamp | action_timestamp |     user_timezone     | day_date 


Liczba komentarzy na jednego posta
select post_id, count(action_timestamp) from fb group by post_id  
having count(action_timestamp) >1 order by count(action_timestamp) desc;

Liczba komentarzy od tego samego uzytkownika na jednego posta
select post_id, actor_id, count(action_timestamp) from fb group by post_id, actor_id
having count(action_timestamp) >1 order by count(action_timestamp) desc;

