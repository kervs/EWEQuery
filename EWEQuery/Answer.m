//
//  Answer.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/24/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "Answer.h"

@implementation Answer

@dynamic answer;
@dynamic askedBy;
@dynamic questionPosted;

+ (NSString *)parseClassName {
    return @"Answer";
}

@end
