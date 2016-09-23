//
//  tweetsViewController.h
//  Twitter
//
//  Created by Ankur Motreja on 9/21/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tweetsViewController : UIViewController

@property(nonatomic, strong) NSString *endpoint;

- (void)fetchTweets;

@end
