//
//  CustomMainViewCell.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/17/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "CustomMainViewCell.h"
@interface CustomMainViewCell ()

@end

@implementation CustomMainViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.smileyFace = [[UIImageView alloc] init];
        self.numberOfAnswers = [[UILabel alloc] init];
        self.questionAsk = [[UILabel alloc] init];
        self.indicatorOfInterest = [[UIImageView alloc] init];
        self.questionAsk.numberOfLines = 0;
        
        
        for (UIView *view in @[self.smileyFace, self.numberOfAnswers, self.questionAsk, self.indicatorOfInterest]) {
            [self.contentView addSubview:view];
            
        }
        
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    
    self.smileyFace.frame = CGRectMake(250, 20, 30, 30);
    
    self.questionAsk.frame = CGRectMake(20, 20, 200, 50);
    
    self.numberOfAnswers.frame = CGRectMake(20, 70, 100, 20);
    
    self.indicatorOfInterest.frame = CGRectMake(120, 70, 40, 20);
        
}




@end
