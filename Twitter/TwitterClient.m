//
//  TwitterClient.m
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "TwitterClient.h"
#import "User.h"

NSString * const twitterConsumerKey = @"w6twAFAEsvTr2DgCZYift1vS1";
NSString * const twitterConsumerSecret = @"RsWveAUUvye3wRQgXdwd3x86qDeMucKATMBm0LuEziBO4juVRm";
NSString * const twitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *)sharedInstance; {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:twitterBaseUrl] consumerKey:twitterConsumerKey consumerSecret:twitterConsumerSecret];
        }
    });
    
    return instance;
}

- (void) login: (void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    
    BDBOAuth1SessionManager *twitterClient;
    twitterClient = [TwitterClient sharedInstance];
    
    [twitterClient deauthorize];
    [twitterClient fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"twitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        
        NSString *authURLString = [@"https://api.twitter.com/oauth/authorize" stringByAppendingFormat:@"?oauth_token=%@", requestToken.token];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURLString] options:@{} completionHandler:^(BOOL success) {
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        self.loginCompletion(nil, error);
    }];

}

- (void)openURL:(NSURL *)url {    
    BDBOAuth1SessionManager *twitterClient = [TwitterClient sharedInstance];
    
    BDBOAuth1Credential *requestToken = [BDBOAuth1Credential credentialWithQueryString:url.query];
    
    [twitterClient fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:requestToken success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"got access token: %@", accessToken.token);
        self.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
        
        [twitterClient GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            NSLog(@"response: %@", responseObject);
            
            User *user = [[User alloc] initWithDictionary:responseObject];
            //[User setCurrentUser:user];
            self.loginCompletion(user, nil);
            
            NSLog(@"%@", user.name);
            NSLog(@"%@", user.screenname);
            NSLog(@"%@", user.tagline);
            NSLog(@"%@", user.profileURL);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error.localizedDescription);
            self.loginCompletion(nil, error);
        }];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        self.loginCompletion(nil, error);
    }];
    
}

@end
