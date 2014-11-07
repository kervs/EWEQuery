//
//  DataSource.h
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/16/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DataSource : UIViewController 

- (void) postQuery:(NSString *)question andPost:(PFUser *)user;
- (void) postAnswer:(NSString *)answer answerBy:(PFUser *)user toThisQuestion:(PFObject *)question;
-(void) userImage:(UIImage *) image userAboutMe:(NSString *)aboutMe;

@end
