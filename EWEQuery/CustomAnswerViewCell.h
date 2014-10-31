//
//  CustomAnswerViewCell.h
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/27/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Parse/Parse.h>

@interface CustomAnswerViewCell : PFTableViewCell
@property (nonatomic, strong) PFObject *currentAnswer;

@end
