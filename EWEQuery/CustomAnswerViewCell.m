//
//  CustomAnswerViewCell.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/27/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "CustomAnswerViewCell.h"
@interface CustomAnswerViewCell ()
@property (nonatomic, strong) UIImageView *smileyFace;
@property (nonatomic, strong) UILabel *numberOfLikes;
@property (nonatomic, strong) UILabel *answerLbl;
@property (nonatomic, strong) UIButton *likeButton;

@end

@implementation CustomAnswerViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.smileyFace = [[UIImageView alloc] init];
        self.answerLbl = [[UILabel alloc] init];
        self.numberOfLikes = [[UILabel alloc] init];
        self.likeButton = [[UIButton alloc] init];
        [self.likeButton setImage:[UIImage imageNamed:@"likeNotFill"] forState:UIControlStateNormal];
        [self.likeButton addTarget:self action:@selector(likeButtonFired:) forControlEvents:UIControlEventTouchUpInside];
        self.answerLbl.numberOfLines = 0;
        
        
        for (UIView *view in @[self.smileyFace, self.answerLbl, self.numberOfLikes, self.likeButton]) {
            [self.contentView addSubview:view];
            
        }
        
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    
    self.smileyFace.frame = CGRectMake(20, 120, 30, 30);
    
    self.answerLbl.frame = CGRectMake(20, 20, 200, 100);
    
    self.numberOfLikes.frame = CGRectMake(70, 120, 100, 20);
    
    self.likeButton.frame = CGRectMake(240, 120, 40, 40);
    
}

- (void)setCurrentAnswer:(PFObject *)currentAnswer {
    _currentAnswer = currentAnswer;
    
    _answerLbl.text = [currentAnswer objectForKey:@"answer"];
    _smileyFace.image = [UIImage imageNamed:@"happy"];
    _numberOfLikes.text = @"99 likes";
}

- (void)likeButtonFired: (id) sender {
    // pass this along to AnswerViewController (or any class)
    [_currentAnswer addUniqueObject:[PFUser currentUser].objectId forKey:@"likes"];
    [_currentAnswer saveInBackground];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
