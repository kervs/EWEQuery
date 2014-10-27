//
//  Query.h
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/23/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Parse/Parse.h>

@interface Query : PFObject<PFSubclassing>

+ (NSString *)parseClassName;
@property (retain) NSString *query;
@property (retain) PFUser *askedBy;



@end
