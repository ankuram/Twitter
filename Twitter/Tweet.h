//
//  Tweet.h
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic) NSInteger retweetCount;
@property (nonatomic) NSInteger favoriteCount;

- (id) initWithDictionary:(NSDictionary *)dictionary;

@end
