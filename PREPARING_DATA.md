

1. Creating the db + table fb
create_database_openddadta_klouts.sql
2. Bash script load_data.sh

```sql
COPY fb(user_id,actor_id,post_id,post_timestamp,action_timestamp) TO '/Users/admin/Desktop/fb.csv' DELIMITER ',' CSV HEADER;

```

      user_id       |       actor_id       |       post_id       | post_timestamp | action_timestamp |     user_timezone     | day_date 


Liczba komentarzy na jednego posta
```sql
select post_id, count(action_timestamp) from fb group by post_id  
having count(action_timestamp) >1 order by count(action_timestamp) desc;
```

Liczba komentarzy >1 od tego samego uzytkownika na jednego posta
```sql
select post_id, actor_id, count(action_timestamp) from fb group by post_id, actor_id
having count(action_timestamp) >1 order by count(action_timestamp) desc;
```


Liczba komentarzy od tego samego uzytkownika na jednego posta danego usera
```sql
Copy (select user_id, post_id, actor_id, count(action_timestamp) from fb group by user_id, post_id, actor_id
order by count(action_timestamp) desc)
To '/Users/admin/Desktop/data/opendata_klout/csv/actors_comments_per_post.csv' With CSV DELIMITER ',';
```

```sql
create table fb_comment_counts as (
select user_id, post_id, actor_id, count(action_timestamp) from fb group by user_id, post_id, actor_id
order by count(action_timestamp) desc
);
```

Liczba unikalnych uzytkownikow ktorzy robili reakcje na jednego posta danego usera
```sql
copy (
select user_id, post_id, count(distinct actor_id) from fb group by user_id, post_id
order by count(distinct actor_id) desc
) To '/Users/admin/Desktop/data/opendata_klout/csv/distinct_actors_per_post.csv' With CSV DELIMITER ',';
```

```sql
create table pri as(
select user_id, post_id, count(distinct actor_id) as user_reacted_count, sum(actor_reaction_count) as reaction_sum from post_reacion_intensity group by user_id, post_id
order by count(distinct actor_id) desc
);
```

Liczba aktywnych uzytkownikow dla danego uzytkownika w calej bazie
```sql
copy (
select user_id, count(distinct actor_id) from fb group by user_id
order by count(distinct actor_id) desc
) To '/Users/admin/Desktop/data/opendata_klout/csv/distinct_actors_generally.csv' With CSV DELIMITER ',';
```
```sql
create table spread as (
	select user_id, count(distinct actor_id) as active_users from fb_comment_counts group by user_id
order by count(distinct actor_id) desc
);

```

