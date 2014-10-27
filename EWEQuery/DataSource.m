//
//  DataSource.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/16/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "DataSource.h"
#import "Answer.h"
#import "Query.h"
#import <Parse/Parse.h>
#import <FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@implementation DataSource

- (void) postQuery:(NSString *)question andPost:(PFUser *)user{
    Query *newQuestion = [[Query alloc]init];
    
    [newQuestion setQuery:question];
    [newQuestion setAskedBy:user];
    
    // Set ACL permissions for added security
    PFACL *newQuestionACL = [PFACL ACLWithUser:user];
    [newQuestionACL setPublicReadAccess:YES];
    [newQuestion setACL:newQuestionACL];
    
    // Save new Post object in Parse
    [newQuestion saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"the error is %@",error);
        }
    }];
    
    
}


- (void) postAnswer:(NSString *)answer answerBy:(PFUser *)user toThisQuestion:(PFObject *)question {
    
    Answer *newAnswer = [[Answer alloc]init];
    
    [newAnswer setAnswer:answer];
    [newAnswer setAskedBy:user];
    [newAnswer setQuestionPosted:question];
    
    // Set ACL permissions for added security
    PFACL *newAnswerACL = [PFACL ACLWithUser:user];
    [newAnswerACL setPublicReadAccess:YES];
    [newAnswer setACL:newAnswerACL];
    
    // Save new Post object in Parse
    [newAnswer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"the error is %@",error);
        }
    }];

}


@end
