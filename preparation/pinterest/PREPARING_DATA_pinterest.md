

1. Creating the db + table fb
create_database_pinterest.sql


```sql
create table joined_table as (
select 	user_id, post_id, actor_id, 1 as repins, 0 as likes from repins);

insert into joined_table (user_id, post_id, actor_id, repins, likes) select user_id, post_id, actor_id, 0, 1 from likes;


create table summary_user_likes_repins as(
select user_id, post_id, sum(repins) as repins_no, sum(likes) as likes_no, count(distinct actor_id) from joined_table group by user_id, post_id
);

COPY (select * from summary_user_likes_repins order by count desc) TO '/Users/admin/Desktop/data/opendata_klout/data/pinterest/summary_user_likes_repins.csv' DELIMITER ',' CSV HEADER;


create table summary_post_counts_per_user as (
select 	user_id, count(distinct post_id) as posts_no, count(distinct actor_id) as distinct_actors_no from joined_table group by user_id order by count(post_id)
);

COPY (select * from summary_post_counts_per_user order by posts_no,distinct_actors_no desc) TO '/Users/admin/Desktop/data/opendata_klout/data/pinterest/summary_post_counts_per_user.csv' DELIMITER ',' CSV HEADER;

```
```sql

select count(distinct user_id) from joined_table; 1307527
select count(distinct actor_id) from joined_table; --8314067
select count(distinct post_id) from joined_table; select sum(posts_no) from summary_post_counts_per_user; --2 362 006 
select sum(repins_no) from summary_user_likes_repins; select count(*) from repins;  37087685
select sum(likes_no) from summary_user_likes_repins; select count(*) from likes; 19332254


######################################################TO WSZYTOK CHYBA ZLE######################################################
#########
#########
#########
#########
#########
#########


create table REPINS_repins_counts_actor_per_post as (
select 	user_id, post_id, count(actor_id) as repins_count, count(distinct actor_id) actor_count from repins group by user_id, post_id order by count(actor_id)
);

#select count(*) from REPINS_repins_counts_actor_per_post where repins_count>actor_count;	

#select count(*) from REPINS_repins_counts_actor_per_post where repins_count<actor_count;	


create table LIKES_repins_counts_per_post as (
select 	user_id, post_id, count(actor_id) as likes_count from likes group by user_id, post_id order by count(actor_id)
);

create table user_likes_repins as(
select LIKES_repins_counts_per_post.user_id, LIKES_repins_counts_per_post.post_id, coalesce(repins_count,0) as repins_no, coalesce(likes_count,0) as likes_no, actor_count from LIKES_repins_counts_per_post join REPINS_repins_counts_actor_per_post on LIKES_repins_counts_per_post.post_id = REPINS_repins_counts_actor_per_post.post_id
);

COPY (select * from user_likes_repins order by actor_count  desc) TO '/Users/admin/Desktop/data/opendata_klout/data/pinterest/user_likes_repins.csv' DELIMITER ',' CSV HEADER;

```
```sql
create table REPINS_post_counts_per_user as (
select 	user_id, count(distinct post_id) as posts_count, count(distinct actor_id) as actors from repins group by user_id order by count(post_id)
);
create table LIKES_post_counts_per_user as (
select 	user_id, count(distinct post_id) as posts_count,  count(distinct actor_id) as actors from likes group by user_id order by count(post_id)
);

create table post_counts_per_user as (
select 	LIKES_post_counts_per_user.user_id, REPINS_post_counts_per_user.posts_count+LIKES_post_counts_per_user.posts_count as posts_no,   REPINS_post_counts_per_user.actors+LIKES_post_counts_per_user.actors as distinct_actors_no from REPINS_post_counts_per_user join LIKES_post_counts_per_user on  REPINS_post_counts_per_user.user_id=LIKES_post_counts_per_user.user_id
);

COPY (select * from post_counts_per_user order by posts_no,distinct_actors_no desc) TO '/Users/admin/Desktop/data/opendata_klout/data/pinterest/post_counts_per_user.csv' DELIMITER ',' CSV HEADER;

```
