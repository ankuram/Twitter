//
//  TweetCell.h
//  Twitter
//
//  Created by Ankur Motreja on 9/21/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@property (weak, nonatomic) UIViewController *viewController;

- (void)setTweet:(Tweet *)tweet;

@end
