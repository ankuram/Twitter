//
//  tweetsViewController.m
//  Twitter
//
//  Created by Ankur Motreja on 9/21/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "tweetsViewController.h"
#import "tweetViewController.h"
#import "ComposeViewController.h"
#import "profileViewController.h"
#import "TwitterClient.h"
#import "TweetCell.h"
#import "Tweet.h"

@interface tweetsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray* tweets;

@property (strong, nonatomic) UIRefreshControl *refreshTweetsControl;

@end

@implementation tweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //User *user = [User getCurrentUser];
    
    self.refreshTweetsControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshTweetsControl];
    [self.refreshTweetsControl addTarget:self action:@selector(refreshTweets) forControlEvents:UIControlEventValueChanged];
    

    if ([self.endpoint isEqualToString:@"timeline"]) {
        [[TwitterClient sharedInstance] homeTimeline:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            [self.tableView reloadData];
            [self.refreshTweetsControl endRefreshing];
        }];
    } else {
        [[TwitterClient sharedInstance] mentionsTimeline:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            [self.tableView reloadData];
            [self.refreshTweetsControl endRefreshing];
        }];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTweets {
    [self fetchTweets];
}

- (void)fetchTweets {
    NSLog(@"fetchTweets called - %@", self.endpoint);
    if ([self.endpoint isEqualToString:@"timeline"]) {
        [[TwitterClient sharedInstance] homeTimeline:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            [self.tableView reloadData];
            [self.refreshTweetsControl endRefreshing];
        }];
    } else {
        [[TwitterClient sharedInstance] mentionsTimeline:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            [self.tableView reloadData];
            [self.refreshTweetsControl endRefreshing];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet;
    
    tweet = self.tweets[indexPath.row];
    
    cell.viewController = self;
    
    [cell setTweet:tweet];
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath;
    
    indexPath = [self.tableView indexPathForCell:cell];
    
    if ([segue.identifier isEqualToString:@"viewTweetSegue"]) {
        TweetViewController *vc = segue.destinationViewController;
    
        vc.tweet = self.tweets[indexPath.row];
        vc.title = @"Tweet";
    } else if ([segue.identifier isEqualToString:@"profileSegue"]) {
        profileViewController *vc = segue.destinationViewController;
        Tweet *tweet =self.tweets[indexPath.row];
        vc.user = tweet.user;
        vc.title = @"Profile";
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
