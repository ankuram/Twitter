//
//  MenuViewController.h
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LayoutViewController : UIViewController

- (void) openMenu;
- (void) closeMenu;

- (void)setContentViewController:(UIViewController *)contentViewController;

@end
