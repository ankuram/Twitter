//
//  ComposeViewController.h
//  Twitter
//
//  Created by Ankur Motreja on 9/22/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface ComposeViewController : UIViewController

@property (nonatomic, strong) Tweet *replyToTweet;

@end
