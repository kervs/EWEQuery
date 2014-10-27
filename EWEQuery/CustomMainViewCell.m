//
//  CustomMainViewCell.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/17/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "CustomMainViewCell.h"
@interface CustomMainViewCell ()
@property (nonatomic, strong) UIImageView *smileyFace;
@property (nonatomic, strong) UILabel *numberOfAnswers;
@property (nonatomic, strong) UITextView *questionAsk;
@property (nonatomic, strong) UIImageView *indicatorOfInterest;

@end

@implementation CustomMainViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.smileyFace = [[UIImageView alloc] init];
        self.numberOfAnswers = [[UILabel alloc] init];
        self.questionAsk = [[UITextView alloc] init];
        self.indicatorOfInterest = [[UIImageView alloc] init];
        
        
        for (UIView *view in @[self.smileyFace, self.numberOfAnswers, self.questionAsk, self.indicatorOfInterest]) {
            [self.contentView addSubview:view];
            
        }
        
    }
    return self;
}



@end
