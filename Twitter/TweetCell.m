//
//  TweetCell.m
//  Twitter
//
//  Created by Ankur Motreja on 9/21/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import <UIImageView+AFNetworking.h>

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    [self.profileImage setImageWithURL:[NSURL URLWithString:tweet.user.profileURL]];
    
    self.name.text = tweet.user.name;
    self.username.text = [@"@" stringByAppendingFormat:@"%@", tweet.user.screenname];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy"];
    self.date.text = [dateFormat stringFromDate:tweet.createdAt];
    
    self.tweetText.text = tweet.text;
}

@end
