

1. Creating the db + table fb
create_database_openddadta_klouts.sql
2. Bash script load_data.sh

```sql
COPY fb(user_id,actor_id,post_id,post_timestamp,action_timestamp) TO '/Users/admin/Desktop/fb.csv' DELIMITER ',' CSV HEADER;

```

      user_id       |       actor_id       |       post_id       | post_timestamp | action_timestamp |     user_timezone     | day_date 

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
select user_id, post_id, actor_id, count(action_timestamp) as actor_reaction_count from fb group by user_id, post_id, actor_id
order by count(action_timestamp) desc
);
```
Liczba distinct uzytkownikow reagujacych na dany post i suma reakcji na dany post
```sql
create table pri as(
	select user_id, post_id, count(distinct actor_id) as user_reacted_count, sum(actor_reaction_count) as reaction_sum 
	from fb_comment_counts group by user_id, post_id
order by count(distinct actor_id) desc
);
```
Liczba aktywnych uzytkownikow dla danego uzytkownika w calej bazie
```sql
create table spread as (
	select user_id, count(distinct actor_id) as active_users from fb_comment_counts group by user_id
order by count(distinct actor_id) desc
);

```

```sql
copy (select * from spread) To '/Users/admin/Desktop/data/opendata_klout/csv/spread.csv'  DELIMITER ',' CSV HEADER;

copy (select * from pri) To '/Users/admin/Desktop/data/opendata_klout/csv/pri.csv'   DELIMITER ',' CSV HEADER;

```
Czy jest wiecej aktywnych userow niz zliczonych komentarzy (test bledu bazy):

```sql
select user_id from pri where user_reacted_count>reaction_sum;
 user_id 
---------
(0 rows)
```

liczba postow tego samego uzytkownika (30)
```sql
select count(distinct post_id) from fb where user_id = 4802661848546193750;
select count(*) from pri where user_id=4802661848546193750;
```

ilczba komentarzy jakie kiedykolwiek dostal (98)
```sql
select count(action_timestamp) from fb where user_id = 4802661848546193750;
select sum(reaction_sum) from pri where user_id=4802661848546193750;
```

suma distinct uzytkownikow ktorzy pisali per post(84)
```sql
#select post_id,count(distinct actor_id) as x from fb where user_id = 4802661848546193750 group by post_id order by x;
#select post_id, user_reacted_count from pri where user_id = 4802661848546193750;         

select sum(x) from (
select post_id,count(distinct actor_id) as x from fb where user_id = 4802661848546193750 group by post_id order by x
) as foo;

select sum(user_reacted_count) from pri where user_id = 4802661848546193750; 

```

