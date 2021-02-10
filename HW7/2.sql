CREATE INDEX follower_count_idx ON Tweeter(followers_count) USING BTREE;
CREATE INDEX hashtagidx ON Hashtags(hashtag) USING BTREE;