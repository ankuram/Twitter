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
    
    NSString *createdAtString = dictionary[@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
    
    self.createdAt = [formatter dateFromString:createdAtString];
    
    self.retweetCount = [dictionary[@"retweet_count"] integerValue];
    self.favoriteCount = [dictionary[@"favorite_count"] integerValue];
    
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

@end
