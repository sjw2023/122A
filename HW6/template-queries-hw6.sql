--
-- Question 5a (stored procedure template)
--
DELIMITER //
CREATE PROCEDURE RegisterChecker(
    user_id integer,
    name_first varchar(50),
    name_last varchar(50), 
    email varchar(100),
    password varchar(30),
    profile_pic varchar(500),
    address_country varchar(30),
    address_state varchar(30),
    address_city varchar(30),
    office_number varchar(20)
)
BEGIN 
    ...
END;  //
DELIMITER ;

-- 
-- Question 5b (query to execute)
-- 
CALL RegisterChecker (
   3000,
   "Peter",
   "Anteater",
   "peter-anteater2020@gmail.com",
   "pretend-this-is-hashed",
   null, 
   "USA",
   "California",
   "Irvine",
   "(949) 824-5011"
);

SELECT U.user_id, U.email, U.profile_pic, C.checker_since, P.number, P.kind
FROM User U, Checker C, Phone P
WHERE U.user_id = C.user_id AND 
      P.user_id = C.user_id AND
	  U.user_id = 3000;
      
-- 
-- Question 6b (INSERT and queries to execute)
--
INSERT INTO Evidence (ev_id, url, isbn)
VALUES (2000, NULL, "0-1306-3278-3");

SELECT COUNT(*) AS url_evidence 
FROM Evidence
WHERE url IS NOT NULL;

SELECT COUNT(*) AS book_evidence
FROM Evidence
WHERE isbn IS NOT NULL;

--
-- Question 7a (trigger template)
-- 
DELIMITER //
CREATE TRIGGER update_tweet_info
...
FOR EACH ROW
BEGIN
...
END; //
DELIMITER ;

--
-- Question 7a Hint 1 (get Tweeter info)
--
SELECT JSON_UNQUOTE(JSON_EXTRACT(content, '$.user.screen_name')) AS display_name,
    JSON_UNQUOTE(JSON_EXTRACT(content, '$.user.followers_count')) AS followers_count,
    JSON_UNQUOTE(JSON_EXTRACT(content, '$.user.name')) AS handle,
    JSON_UNQUOTE(JSON_EXTRACT(content, '$.user.id_str')) AS tweeter_id,
    CASE WHEN JSON_EXTRACT(content, '$.user.verified') THEN 1 ELSE 0 END AS verified
FROM RawTweet T
LIMIT 1;

--
-- Question 7a Hint 2 (get Tweet info)
--
SELECT JSON_UNQUOTE(JSON_EXTRACT(T.content, '$.created_at')) AS posting_datetime,
    JSON_EXTRACT(T.content, '$.geo.coordinates[0]') AS posting_location_latitude,
    JSON_EXTRACT(T.content, '$.geo.coordinates[1]') AS posting_location_longitude,
    JSON_EXTRACT(T.content, '$.quoted_status_id') AS quoted_tweet,
    JSON_EXTRACT(T.content, '$.in_reply_to_status_id') AS replied_to_tweet,
    JSON_UNQUOTE(JSON_EXTRACT(T.content, '$.id')) AS tweet_id,
    JSON_UNQUOTE(JSON_EXTRACT(T.content, '$.text')) AS tweet_text,
    JSON_UNQUOTE(JSON_EXTRACT(T.content, '$.user.id_str')) AS tweeter_id
FROM RawTweet T
LIMIT 1;

--
-- Question 7a Hint 3 (update Hashtag table)
--
CALL UpdateHashtags(tweet_id);

--
-- Question 7b Query 1
--
SELECT TW.followers_count, COUNT(DISTINCT T.tweet_id) AS tweets_posted,
                           COUNT(DISTINCT H.hashtag) AS total_hashtags 
FROM Tweeter TW
LEFT OUTER JOIN Tweet T ON TW.tweeter_id = T.tweeter_id
LEFT OUTER JOIN Hashtags H ON T.tweet_id = H.tweet_id
WHERE TW.tweeter_id = T.tweeter_id
AND T.tweeter_id = '1121141389696413697';

-- 
-- Question 7b Insert 1 w/ Query 1
--
 INSERT INTO RawTweet VALUES (
    "1321203503310762222",
    '{"id": "1321203503310762222", "created_at": "2020-06-12 14:56:40", "extended_tweet": {"entities": {"hashtags": [{"indices": [136, 145], "text": "criminals"}, {"indices": [147, 158], "text": "Obidengate2020"}, {"indices": [159, 169], "text": "obamagate"}, {"indices": [170, 178], "text": "treason"}, {"indices": [179, 198], "text": "politicalespionage"}, {"indices": [199, 219], "text": "seditiousconspiracy"}, {"indices": [220, 235], "text": "4yrsrussialies"}, {"indices": [236, 262], "text": "fbidocsproveHRCrussiahoax"}], "user_mentions": [{"indices": [0, 9], "screen_name": "LLinda_W", "id_str": "3303621560", "name": "LindaW- #VoteBlueDownBallot", "id": 3303621560}, {"indices": [10, 23], "screen_name": "WardDPatrick", "id_str": "3353220134", "name": "Pat Ward", "id": 3353220134}]}, "full_text": "@LLinda_W @WardDPatrick Truly nauseating to hear the excuses and defensive epic fails coming from antiamerican actually voting for this #criminal  #Obidengate #obamagate #treason #politicalespionage #seditiousconspiracy #4yrsrussialies #fbidocsproveHRCrussiahoax   https://t.co/Q98eyjmpBC"}, "retweet_count": 0, "retweeted": false, "filter_level": "low", "in_reply_to_screen_name": "LLinda_W", "is_quote_status": false, "id_str": "1321203503310762222", "favorite_count": 0, "text": "@LLinda_W @WardDPatrick Truly nauseating to hear the excuses and defensive epic fails coming from antiamerican actu\u2026 https://t.co/tDmveFKMDf", "lang": "en", "quote_count": 0, "favorited": false, "possibly_sensitive": false, "truncated": true, "timestamp_ms": "1603834143603", "reply_count": 0, "user": {"friends_count": 911, "profile_image_url_https": "https://pbs.twimg.com/profile_images/1280133701599404032/9HYrUqHg_normal.jpg", "listed_count": 1, "profile_background_image_url": "", "default_profile_image": false, "favourites_count": 9141, "description": "\u26a1 #Seditiousconspiracy", "is_translator": false, "profile_background_image_url_https": "", "protected": false, "screen_name": "WrathchiksMama", "id_str": "1121141389696413697", "profile_link_color": "1DA1F2", "translator_type": "none", "id": 1121141389696413697, "geo_enabled": false, "profile_background_color": "F5F8FA", "profile_sidebar_border_color": "C0DEED", "profile_text_color": "333333", "verified": false, "profile_image_url": "http://pbs.twimg.com/profile_images/1280133701599404032/9HYrUqHg_normal.jpg", "url": "https://www.altcensored.com/watch?v=9HFxVvrXjCg", "contributors_enabled": false, "profile_background_tile": false, "profile_banner_url": "https://pbs.twimg.com/profile_banners/1121141389696413697/1594042636", "statuses_count": 7648, "followers_count": 219, "profile_use_background_image": true, "default_profile": true, "name": "ThePlotAgainstPresident", "location": "\ud83d\udc47\ud83d\udc47WATCH&SHARE!#SaveOur1A\ud83d\udc47\ud83d\udc47", "profile_sidebar_fill_color": "DDEEF6"}}'
);

SELECT TW.followers_count, COUNT(DISTINCT T.tweet_id) AS tweets_posted,
                           COUNT(DISTINCT H.hashtag) AS total_hashtags 
FROM Tweeter TW
LEFT OUTER JOIN Tweet T ON TW.tweeter_id = T.tweeter_id
LEFT OUTER JOIN Hashtags H ON T.tweet_id = H.tweet_id
WHERE TW.tweeter_id = T.tweeter_id
AND T.tweeter_id = '1121141389696413697';

--
-- Question 7b Query 2
--
SELECT TW.followers_count, COUNT(DISTINCT T.tweet_id) AS tweets_posted,
                           COUNT(DISTINCT H.hashtag) AS total_hashtags 
FROM Tweeter TW
LEFT OUTER JOIN Tweet T ON TW.tweeter_id = T.tweeter_id
LEFT OUTER JOIN Hashtags H ON T.tweet_id = H.tweet_id
WHERE TW.tweeter_id = T.tweeter_id
AND T.tweeter_id = '992109555483103122';

--
-- Question 7b Insert 2 w/ Query 2
--

INSERT INTO RawTweet VALUES (
    "1321203503310762322",
    '{"id": "1321203503310762322", "created_at": "2020-04-29 05:29:03", "retweet_count": 0, "retweeted": false, "filter_level": "low", "is_quote_status": false, "id_str": "1321203503310762322", "favorite_count": 0, "text": "Harris County early voting hours extended to 10 p.m. until Thursday https://t.co/VF9uvQlJwK) **LETS GO, HARRIS COU\u2026 https://t.co/k7pt7SRIN5", "lang": "en", "quote_count": 0, "favorited": false, "possibly_sensitive": false, "truncated": true, "timestamp_ms": "1603832187724", "reply_count": 0, "entities": {"urls": [{"display_url": "chron.com/news/election2\u2026", "indices": [68, 91], "expanded_url": "https://www.chron.com/news/election2020/article/Harris-County-early-voting-hours-extended-to-10-15677986.php?utm_campaign=CMS%20Sharing%20Tools%20(Premium", "url": "https://t.co/VF9uvQlJwK"}, {"display_url": "twitter.com/i/web/status/1\u2026", "indices": [117, 140], "expanded_url": "https://twitter.com/i/web/status/1321194070757330945", "url": "https://t.co/k7pt7SRIN5"}]}, "user": {"friends_count": 22468, "profile_image_url_https": "https://pbs.twimg.com/profile_images/1057463467286773760/wKFC-Ixa_normal.jpg", "listed_count": 6, "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png", "default_profile_image": false, "favourites_count": 20682, "description": "JUJUS BU PRU VETTED NICE LADY, BUT, PLEASE DONT HIT ON ME. MARRIED CLOSE TO 40 YRS. CRITTER LOVER. PRO CLIMATE 4 ALL KIDS. MAIN ACCT@jjsmokkieBOY57", "is_translator": false, "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png", "protected": false, "screen_name": "smokesdad289", "id_str": "992109555483103122", "profile_link_color": "FF691F", "translator_type": "none", "id": 992109555483103122, "geo_enabled": false, "profile_background_color": "000000", "profile_sidebar_border_color": "000000", "profile_text_color": "000000", "verified": false, "profile_image_url": "http://pbs.twimg.com/profile_images/1057463467286773760/wKFC-Ixa_normal.jpg", "contributors_enabled": false, "profile_background_tile": false, "profile_banner_url": "https://pbs.twimg.com/profile_banners/992109555483103232/1541111709", "statuses_count": 62229, "followers_count": 20476, "profile_use_background_image": false, "default_profile": false, "name": "jujus other", "location": "texas", "profile_sidebar_fill_color": "000000"}}'
);

SELECT TW.followers_count, COUNT(DISTINCT T.tweet_id) AS tweets_posted, 
                           COUNT(DISTINCT H.hashtag) AS total_hashtags 
FROM Tweeter TW
LEFT OUTER JOIN Tweet T ON TW.tweeter_id = T.tweeter_id
LEFT OUTER JOIN Hashtags H ON T.tweet_id = H.tweet_id
WHERE TW.tweeter_id = T.tweeter_id
AND T.tweeter_id = '992109555483103122';


