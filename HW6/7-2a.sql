SELECT TW.followers_count, COUNT(DISTINCT T.tweet_id) AS tweets_posted,
                           COUNT(DISTINCT H.hashtag) AS total_hashtags 
FROM Tweeter TW
LEFT OUTER JOIN Tweet T ON TW.tweeter_id = T.tweeter_id
LEFT OUTER JOIN Hashtags H ON T.tweet_id = H.tweet_id
WHERE TW.tweeter_id = T.tweeter_id
AND T.tweeter_id = '1121141389696413697';
