//
//  Tweet.m
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id) initWithDictionary:(NSDictionary *)dictionary  {
    self.text = dictionary[@"text"];
    
    self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
    
    NSString *createdAtString = dictionary[@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
    
    self.createdAt = [formatter dateFromString:createdAtString];
    
    self.retweetCount = [dictionary[@"retweet_count"] integerValue];
    self.favoriteCount = [dictionary[@"favorite_count"] integerValue];
    
    self.idStr = dictionary[@"id_str"];
    
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

- (id) initWithText:(NSString *)text replyToTweet:(Tweet *)replyToTweet {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
    
    NSDictionary *data = [NSDictionary dictionary];
    NSDictionary *user = [NSDictionary dictionary];
    User *currentUser = [User getCurrentUser];
    
    user = @{
             @"name" : currentUser.name,
             @"screen_name" : currentUser.screenname,
             @"profile_image_url" : currentUser.profileURL,
             @"description" : currentUser.tagline
             };
    
    data = @{
             @"user" : user,
             @"text" : text,
             @"created_at" : [formatter stringFromDate:now],
             @"retweeted" : @NO,
             @"favorited" : @NO,
             @"in_reply_to_status_id_str" : replyToTweet ? replyToTweet.idStr : @NO
             };
    
    return [self initWithDictionary:data];
}

@end
