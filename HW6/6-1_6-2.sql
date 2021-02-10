select handle
from Tweeter
where Tweeter.tweeter_id IN ( select tweeter_id
from( select  count(*) as cnt, tweeter_id
	from ( 	select lowercase.hashtag, lowercase.tweet_id, count(*)
		from ( 	select LOWER(hashtag) as hashtag, tweet_id 
				from Hashtags ) as lowercase
		where lowercase.hashtag = 'covid19'
		group by tweet_id ) as covidtweets, Tweet
	where covidtweets.tweet_id = Tweet.tweet_id
	group by tweeter_id ) as cnttb
where cnttb.cnt >3 )




select *
from Tweeter
where followers_count > 500000 and Tweeter.tweeter_id IN (select tweeter_id
from
	(select Hashtags.tweet_id
	from ( 	select count(*), lowercase.hashtag
			from ( select hashtag as hashtag, tweet_id from Hashtags ) as lowercase
			group by lowercase.hashtag
			order by count(*) desc
			limit 10) as topten, Hashtags
	where topten.hashtag = Hashtags.hashtag) as tweetwithtopten, Tweet
where tweetwithtopten.tweet_id = Tweet.tweet_id)



