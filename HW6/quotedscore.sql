select 0.4*( count(*) ), quoted_tweet
from Tweet
group by quoted_tweet