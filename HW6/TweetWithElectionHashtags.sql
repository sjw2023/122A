select *
from Tweet
where tweet_id in ( select tweet_id
from (
select lower(hashtag) as hashtag, tweet_id
from Hashtags
)as lowercase
where lowercase.hashtag ="election2020" or 
lowercase.hashtag ="trump"or 
lowercase.hashtag = "biden" or
lowercase.hashtag = "bidenharris2020" or 
lowercase.hashtag = "trumppence2020" or 
lowercase.hashtag = "pennsylvania"or 
lowercase.hashtag = "northcarolina" or
lowercase.hashtag = "wisconsin" or 
lowercase.hashtag = "michigan" )