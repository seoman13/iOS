//
//  CBContactsTableViewController.m
//  2017-04-25-contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBContactsTableViewController.h"
#import "CBContactsList.h"
#import "CBContactManager.h"
#import "CBContactCell.h"
#import "CBFakeContactsService.h"
#import "CBAuthToken.h"
#import "CBAutorizationController.h"
#import "CBVKContactService.h"

@interface CBContactsTableViewController ()

@property (nonatomic, strong) CBContactsList *contacts;
@property (nonatomic, strong) id<CBContactManager> contactManager;

@end

@implementation CBContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Contacts";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CBContactCell class] forCellReuseIdentifier:CBContactCellIdentifier];
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:loginButton.imageView.image style:UIBarButtonItemStylePlain target:self action:@selector(loginButtonClicked)];
//    btnItem.tintColor = [UIColor blueColor];
//    
//    UIImage *vkImage = [UIImage imageNamed:@"VKLogo"];
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:vkImage];
//    imgView.contentMode = UIViewContentModeScaleAspectFit;
    


//    UIBarButtonItem *btnVKItem = [[UIBarButtonItem alloc] initWithImage:imgView.image style:UIBarButtonItemStylePlain target:self action:@selector(loginVKButtonClicked)];
    
//    btnVKItem.imageInsets = UIEdgeInsetsMake(224, 224, 0, 0);
//    btnVKItem.tintColor = [UIColor redColor];
//    self.navigationItem.rightBarButtonItems = @[btnVKItem, btnItem];

}

- (void)viewDidAppear:(BOOL)animated {
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (CBContactCell *)[tableView dequeueReusableCellWithIdentifier:CBContactCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CBContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CBContactCellIdentifier];
    }
    
    [(CBContactCell *)cell addContact:[self.contacts objectAtIndexedSubscript:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CBContactCell heightForCell];
}

//-(void)loginButtonClicked
//{
//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//    [login logInWithReadPermissions: @[@"public_profile"]
//                fromViewController:self
//                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//         if (error) {
//             NSLog(@"Process error");
//         } else if (result.isCancelled) {
//             NSLog(@"Cancelled");
//         } else {
//             NSLog(@"Logged in");
//         }
//     }];
//}

-(void)loginVKButtonClicked{
    
        if (![CBAuthToken getAccessToken]) {
            CBAutorizationController *authController = [[CBAutorizationController alloc] init];
            [self presentViewController:authController animated:YES completion:nil];
        }
        else {
            self.contactManager = [CBVKContactService new];
            self.contactManager.authToken = [CBAuthToken getAccessToken];
            self.contacts = [self.contactManager getContacts];
            [self.tableView reloadData];
        }

}
@end
