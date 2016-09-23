//
//  TwitterClient.h
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1SessionManager

+ (TwitterClient *)sharedInstance;

- (void)login:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)userTimeline:(User *)user completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)homeTimeline:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)mentionsTimeline:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)sendTweet:(Tweet *)tweet completion:(void (^)(NSString *, NSError *))completion;

@end
