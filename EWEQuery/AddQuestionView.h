//
//  AddQuestionView.h
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/21/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface AddQuestionView : UIViewController

@property (nonatomic,assign)bool *isAnswer;
@property (nonatomic,strong) PFObject *question;

@end
