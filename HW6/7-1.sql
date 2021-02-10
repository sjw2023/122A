USE cs122a_fall20;
DROP TRIGGER IF EXISTS update_tweet_info;
--
-- Question 7a (trigger template)
-- 
DELIMITER //
CREATE TRIGGER update_tweet_info
after insert on RawTweet
FOR EACH ROW
BEGIN
	INSERT INTO Tweeter
    values(JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.user.screen_name')),
    JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.user.followers_count')),
    JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.user.name')),
    JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.user.id_str')),
    CASE WHEN JSON_EXTRACT(new.content, '$.user.verified') THEN 1 ELSE 0 END
    )
	ON DUPLICATE KEY UPDATE display_name = JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.user.screen_name')),
							followers_count = JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.user.followers_count')),
                            handle = JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.user.name'));
    
	INSERT INTO Tweet
    values( JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.created_at')),
    JSON_EXTRACT(new.content, '$.geo.coordinates[0]'),
    JSON_EXTRACT(new.content, '$.geo.coordinates[1]'),
    JSON_EXTRACT(new.content, '$.quoted_status_id'),
    JSON_EXTRACT(new.content, '$.in_reply_to_status_id'),
    JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.id')) ,
    JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.text')),
    JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.user.id_str'))
    );

		
	CALL UpdateHashtags(JSON_UNQUOTE(JSON_EXTRACT(new.content, '$.id')));
END; //
DELIMITER ;
