//
//  TweetViewController.m
//  Twitter
//
//  Created by Ankur Motreja on 9/22/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "TweetViewController.h"
#import <UIImageView+AFNetworking.h>

@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *retweetsCount;
@property (weak, nonatomic) IBOutlet UILabel *favoritesCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;
@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.tweet.user.profileURL]];
    
    self.name.text = self.tweet.user.name;
    self.username.text = [@"@" stringByAppendingFormat:@"%@", self.tweet.user.screenname];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy h:m a"];
    self.date.text = [dateFormat stringFromDate:self.tweet.createdAt];
    
    self.tweetText.text = self.tweet.text;
    
    self.retweetsCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoritesCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRetweetTap:(UITapGestureRecognizer *)sender {
    [self.retweetImage setHighlighted:[self.tweet retweet]];
}

- (IBAction)onFavoriteTap:(UITapGestureRecognizer *)sender {
    [self.favoriteImage setHighlighted:[self.tweet favorite]];
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
