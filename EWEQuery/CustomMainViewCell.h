//
//  CustomMainViewCell.h
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/17/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Query.h"

@interface CustomMainViewCell : PFTableViewCell

@property (nonatomic, strong) UIImageView *smileyFace;
@property (nonatomic, strong) UILabel *numberOfAnswers;
@property (nonatomic, strong) UILabel *questionAsk;
@property (nonatomic, strong) UIImageView *indicatorOfInterest;


@end
