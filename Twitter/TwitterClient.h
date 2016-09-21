//
//  TwitterClient.h
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1SessionManager

+ (TwitterClient *)sharedInstance;

- (void)login:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

@end
