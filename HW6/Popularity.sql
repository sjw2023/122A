select rept.replied_to_tweet,
	( case 
		when replied_to_tweet = quoted_tweet
        then rept.cnt + quot.cnt
        when quoted_tweet is null and replied_to_tweet is not null
        then rept.cnt
        when quoted_tweet is not null and replied_to_tweet is null
        then quot.cnt
        else null
	end ) as popularity
from 	( select 0.6*( count(*) ) as cnt, replied_to_tweet from Tweet group by replied_to_tweet ) as rept,
		( select 0.4*( count(*) ) as cnt, quoted_tweet from Tweet group by quoted_tweet ) as quot
