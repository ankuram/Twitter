//
//  ComposeViewController.m
//  Twitter
//
//  Created by Ankur Motreja on 9/22/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "ComposeViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import <UIImageView+AFNetworking.h>
#import "Tweet.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    User *user = [User getCurrentUser];
    
    self.name.text = user.name;
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileURL]];
    self.username.text = [@"@" stringByAppendingFormat:@"%@", user.screenname];
    
    self.tweetText.delegate = self;
    
    [self.tweetText becomeFirstResponder];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTweet:(UIButton *)sender {
    Tweet *tweet = [[Tweet alloc] initWithText:self.tweetText.text replyToTweet:nil];
    
    [[TwitterClient sharedInstance] sendTweet:tweet completion:^(NSString *tweetIdStr, NSError *error) {
        if (error) {
            NSLog(@"%@", [NSString stringWithFormat:@"Error sending tweet: %@", tweet]);
        } else {
            // set tweet id so it can be favorited
            NSLog(@"%@", [NSString stringWithFormat:@"Tweet successful, tweet id_str: %@", tweetIdStr]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
