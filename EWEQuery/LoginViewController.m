//
//  LoginViewController.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/16/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "TestMainViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong)UIButton *longinWithFB;

@end

@implementation LoginViewController

- (void)loadView {
    self.view = [[UIView alloc]init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.longinWithFB = [[UIButton alloc]initWithFrame:CGRectMake(60, 250, 200, 50)];
    [self.longinWithFB setTitle:@"Log in with FaceBook" forState:UIControlStateNormal];
    self.longinWithFB.backgroundColor = [UIColor blueColor];
    [self.longinWithFB addTarget:self action:@selector(longinWithFBPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self.view addSubview:self.longinWithFB];
  
}

- (void)longinWithFBPressed: (id)sender {
    
    NSArray *permissionArray = @[@"user_about_me",@"user_interests",@"user_birthday",@"user_relationships",@"user_location", @"user_relationship_details"];
    [PFFacebookUtils logInWithPermissions:permissionArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Log In Error" message:@"Facebook Log In was Canceled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                [alertView show];
            }
            
        } else {
            TestMainViewController *mainView = [[TestMainViewController alloc]init];
            [self updateUserInformation];
            [self.navigationController pushViewController:mainView animated:YES];
        }
    }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    if (user.username != nil) {
        TestMainViewController *mainView = [[TestMainViewController alloc]init];
        [self updateUserInformation];
        [self.navigationController pushViewController:mainView animated:YES];
    }
}

#pragma mark - FB helper method
- (void) updateUserInformation {
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userDictionary = (NSDictionary *)result;
            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc]initWithCapacity:8];
            if (userDictionary[@"name"]) {
                userProfile[@"name"] = userDictionary[@"name"];
            }
            if (userDictionary[@"first_name"]) {
                userProfile[@"first_name"] = userDictionary[@"first_name"];
            }
            if (userDictionary[@"location"][@"name"]) {
                userProfile[@"location"] = userDictionary[@"location"][@"name"];
            }
            if (userDictionary[@"gender"]) {
                userProfile[@"gender"] = userDictionary[@"gender"];
            }
            if (userDictionary[@"birthday"]) {
                userProfile[@"birthday"] = userDictionary[@"birthday"];
            }
            if (userDictionary[@"interested_in"]) {
                userProfile[@"interested_in"] = userDictionary[@"interested_in"];
            }
            [[PFUser currentUser]setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser]saveInBackground];
        }
        else {
            NSLog(@"Error in Facebook request: %@",error);
        }
    }];
}

@end
