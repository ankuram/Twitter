//
//  profileViewController.m
//  Twitter
//
//  Created by Ankur Motreja on 9/21/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "profileViewController.h"
#import "TwitterClient.h"
#import <UIImageView+AFNetworking.h>
#import "TweetCell.h"
#import "Tweet.h"
#import "TweetViewController.h"

@interface profileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray* tweets;

@end

@implementation profileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    User *user = self.user ? self.user : [User getCurrentUser];
    
    [[TwitterClient sharedInstance] userTimeline:user completion:^(NSArray *tweets, NSError *error) {
        NSLog(@"userTimeline returned in profileViewController");
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
    
    self.nameLabel.text = user.name;
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileURL]];
    self.username.text = [@"@" stringByAppendingFormat:@"%@", user.screenname];
    self.tweetCount.text = [NSString stringWithFormat:@"%d", user.tweetCount];
    self.followingCount.text = [NSString stringWithFormat:@"%d", user.friendCount];
    self.followersCount.text = [NSString stringWithFormat:@"%d", user.followerCount];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet;
    
    tweet = self.tweets[indexPath.row];
    
    [cell setTweet:tweet];
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath;
    
    indexPath = [self.tableView indexPathForCell:cell];
    
    if ([segue.identifier isEqualToString:@"profileViewTweetSegue"]) {
        TweetViewController *vc = segue.destinationViewController;
        
        vc.tweet = self.tweets[indexPath.row];
        vc.title = @"Tweet";
    }
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
