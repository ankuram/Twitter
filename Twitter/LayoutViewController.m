//
//  MenuViewController.m
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "LayoutViewController.h"
#import "MenuViewController.h"

@interface LayoutViewController ()

@property (weak, nonatomic) IBOutlet UIView *MenuView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;

@property (strong, nonatomic) MenuViewController *menuViewController;

@property (nonatomic, assign) BOOL isMenuOpen;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isMenuOpen = false;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.menuViewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self addChildViewController:self.menuViewController];
    self.menuViewController.layoutViewController = self;
    self.menuViewController.view.frame = self.MenuView.bounds;
    [self.MenuView addSubview:self.menuViewController.view];
    [self.menuViewController didMoveToParentViewController:self];

    //self.leftMarginConstraint.constant = 200;
    //[self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    [self addChildViewController:contentViewController];
    contentViewController.view.frame = self.ContentView.bounds;
    [self.ContentView addSubview:contentViewController.view];
    [contentViewController didMoveToParentViewController:self];
}

- (void) openMenu {
    [UIView animateWithDuration:0.2 animations:^{
        self.leftMarginConstraint.constant = 200;
        [self.view layoutIfNeeded];
    }];
}

- (void) closeMenu {
    [UIView animateWithDuration:0.2 animations:^{
        self.leftMarginConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    self.leftMarginConstraint.constant = location.x;
    [self.view layoutIfNeeded];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (velocity.x < 0) {
            [self closeMenu];
        } else {
            [self openMenu];
        }
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
