SELECT T.tweet_text
FROM Tweet T, Tweeter TT
WHERE T.tweeter_id = TT.tweeter_id AND TT.handle = 'patgotweet'

SELECT DISTINCT E.domain
FROM Expertise E, Tweet T, Hashtags H, Verification V
WHERE E.user_id = V.user_id AND V.tweet_id = T.tweet_id AND T.tweet_id = H.tweet_id AND H.hashtag = 'COVID19'

SELECT E.url, V.comment, U.name_first, U.name_last
FROM Tweeter TT, Tweet T, Verification V, Checker C
WHERE C.checker_since >= '2020-01-31 03:41:49' AND C.user_id = V.user_id AND V.tweet_id = T.tweet_id AND T.tweeter_id = TT.tweeter_id

SELECT E.url, V.comment, U.name_first, U.name_last
FROM User U, Evidence E, Hashtags H, Checker C, Verification V, Tweet T, VerifiedUsing VU
WHERE  T.tweet_id = V.tweet_id AND V.user_id = C.user_id AND C.user_id = U.user_id AND H.tweet_id = T.tweet_id AND V.ver_id = VU.ver_id AND VU.ev_id = E.ev_id AND H.hashtag = 'COVID19'

SELECT U.user_id, U.name_first, U.name_last 
FROM User U
WHERE U.user_id IN ( SELECT user_id 
FROM Expertise 
WHERE Expertise.domain IN ( SELECT E.domain FROM Expertise E WHERE E.user_id = 68 ) 
GROUP by user_id 
Having Count(*) >= 2)

select number from Phone P, Checker C Where C.user_id = P.user_id AND C.user_id IN ( select user_id from Expertise where domain = "Infectious Diseases" ) 

select t.replied_to_tweet, count(*)
from Tweet t
group by t.replied_to_tweet
having 0 < ( select count(*) from Tweet t2 where t.replied_to_tweet = t2.replied_to_tweet )
order by count(*) DESC
limit 5



select rtable.replied_to_tweet as tweet_id, qtable.numq + rtable.numrep as count
from ( select t.quoted_tweet, count(*) as numq from Tweet t group by t.quoted_tweet order by count(*) DESC limit 5 ) as qtable, 
(select t.replied_to_tweet, count(*) as numrep from Tweet t group by t.replied_to_tweet having 0 < ( select count(*) from Tweet t2 where t.replied_to_tweet = t2.replied_to_tweet ) order by count(*) DESC) as rtable
where rtable.replied_to_tweet = qtable.quoted_tweet
union
select rtable.replied_to_tweet as tweet_id, rtable.numrep
from ( select t.quoted_tweet, count(*) as numq from Tweet t group by t.quoted_tweet order by count(*) DESC limit 5 ) as qtable, 
(select t.replied_to_tweet, count(*) as numrep from Tweet t group by t.replied_to_tweet having 0 < ( select count(*) from Tweet t2 where t.replied_to_tweet = t2.replied_to_tweet ) order by count(*) DESC) as rtable
where rtable.numrep > 1
order by count desc

(select t.replied_to_tweet, count(replied_to_tweet) as numrep
from Tweet t
group by t.replied_to_tweet
having 0 < ( select count(*) from Tweet t2 where t.replied_to_tweet = t2.replied_to_tweet )
order by count(*) DESC)

( select t.quoted_tweet, count(*) as numq
from Tweet t
group by t.quoted_tweet
order by count(*) DESC
limit 5 )