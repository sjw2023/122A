select 0.6*( count(*) ), replied_to_tweet
from Tweet
group by replied_to_tweet