DROP VIEW IF EXISTS `ElectionTweets`; 
CREATE VIEW ElectionTweets (tweeter_id, handle, followers_count, verified, tweet_id, tweet_text) 
as
select TWT.tweeter_id, TWT.handle, TWT.followers_count, TWT.verified, TW.tweet_id, TW.tweet_text, -- , qua
from (	select *
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
		lowercase.hashtag = "michigan" )) as TW, Tweeter TWT
        
where TW.tweeter_id = TWT.tweeter_id ;



select *
from ElectionTweets