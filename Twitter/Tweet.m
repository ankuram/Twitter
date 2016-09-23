//
//  Tweet.m
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "Tweet.h"
#import "TwitterClient.h"

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

- (BOOL) retweet {
    self.retweeted = !self.retweeted;
    if (self.retweeted) {
        [[TwitterClient sharedInstance] retweet:self completion:^(NSString *retweetIdStr, NSError *error) {
            if (error) {
                NSLog(@"Retweet failed");
            } else {
                NSLog(@"%@", [NSString stringWithFormat:@"Retweet successful, retweet_id_str: %@", retweetIdStr]);
                self.retweetIdStr = retweetIdStr;
            }
        }];
    } else {
        [[TwitterClient sharedInstance] unretweet:self completion:^(NSError *error) {
            if (error) {
                NSLog(@"Unretweet failed");
            } else {
                NSLog(@"Unretweet successful");
            }
        }];
    }
    
    return self.retweeted;
}

- (BOOL) favorite {
    self.favorited = !self.favorited;
    if (self.favorited) {
        [[TwitterClient sharedInstance] favorite:self completion:^(NSError *error) {
            if (error) {
                NSLog(@"Favorite failed");
            } else {
                NSLog(@"Favorite successful");
            }
        }];
    } else {
        [[TwitterClient sharedInstance] unfavorite:self completion:^(NSError *error) {
            if (error) {
                NSLog(@"Unfavorite failed");
            } else {
                NSLog(@"Unfavorite successful");
            }
        }];
    }
    
    return self.favorited;
}

@end
