 #!/bin/bash

for foldername in `ls /Users/admin/Desktop/data/klout_data/user_timestamp_open_set_fb.tar`;
do 
thefile=$(ls /Users/admin/Desktop/data/klout_data/user_timestamp_open_set_fb.tar/${foldername}) ;
psql -U postgres -d opendata_klout -c "create table temp(
    user_id bigint NOT NULL,
    actor_id bigint NOT NULL,
    post_id bigint DEFAULT NULL,
    post_timestamp bigint DEFAULT NULL,
    action_timestamp bigint DEFAULT NULL,
    user_timezone varchar(200) DEFAULT NULL,
    day_date bigint DEFAULT ${foldername}
  );";

psql -U postgres -d opendata_klout -c "COPY temp(user_id,actor_id,post_id,post_timestamp,action_timestamp,user_timezone) FROM '/Users/admin/Desktop/data/klout_data/user_timestamp_open_set_fb.tar/${foldername}/${thefile}' DELIMITER E'\t';";

psql -U postgres -d opendata_klout -c "insert into fb select * from temp;";

psql -U postgres -d opendata_klout -c "drop table temp;";

done



