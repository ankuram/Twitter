//
//  User.m
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithDictionary:(NSDictionary *)dictionary  {
    self.name = dictionary[@"name"];
    self.screenname = dictionary[@"screen_name"];
    self.profileURL = dictionary[@"profile_image_url_https"];
    self.backgroundImageUrl = dictionary[@"profile_background_image_url"];
    self.tagline = dictionary[@"description"];
    self.tweetCount = [dictionary[@"statuses_count"] integerValue];
    self.friendCount = [dictionary[@"friends_count"] integerValue];
    self.followerCount = [dictionary[@"followers_count"] integerValue];
    return self;
}

static User *_currentUser = nil;

+ (void)setCurrentUser:(User *)currentUser {
    _currentUser = currentUser;
}

+ (User *)getCurrentUser {
    return _currentUser;
}

@end
