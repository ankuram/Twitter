//
//  USER.m
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
    self.tagline = dictionary[@"description"];
    
    return self;
}

@end
