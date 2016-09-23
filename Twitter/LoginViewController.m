//
//  LoginViewController.m
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "LoginViewController.h"
#import "BDBOAuth1SessionManager.h"
#import "TwitterClient.h"
#import "LayoutViewController.h"

@interface LoginViewController ()

@property (nonatomic) BDBOAuth1SessionManager *twitterClient;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onLoginButton:(UIButton *)sender {
    [[TwitterClient sharedInstance] login:^(User *user, NSError *error) {
        [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        
        //LayoutViewController *vc = [[LayoutViewController alloc] init];
        //[self presentViewController:vc animated:YES completion:nil];
    }];
}

@end
