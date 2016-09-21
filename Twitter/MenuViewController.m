//
//  MenuViewController.m
//  Twitter
//
//  Created by Ankur Motreja on 9/20/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIViewController *profileViewController;
@property (strong, nonatomic) UIViewController *timelineViewController;
@property (strong, nonatomic) UIViewController *mentionsViewController;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView reloadData];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.profileViewController = [storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
    self.timelineViewController = [storyboard instantiateViewControllerWithIdentifier:@"timelineViewController"];
    self.mentionsViewController = [storyboard instantiateViewControllerWithIdentifier:@"mentionsViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"First";
            break;
        case 1:
            cell.textLabel.text = @"Second";
            break;
        case 2:
            cell.textLabel.text = @"Third";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    switch (indexPath.row) {
        case 0:
            [self.layoutViewController setContentViewController:self.profileViewController];
            break;
        case 1:
            [self.layoutViewController setContentViewController:self.timelineViewController];
            break;
        case 2:
            [self.layoutViewController setContentViewController:self.mentionsViewController];
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
