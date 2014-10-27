//
//  Answer.h
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/24/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Parse/Parse.h>

@interface Answer : PFObject<PFSubclassing>

+ (NSString *)parseClassName;
@property (retain) NSString *answer;
@property (retain) PFUser *askedBy;
@property (retain) PFObject *questionPosted;

@end
