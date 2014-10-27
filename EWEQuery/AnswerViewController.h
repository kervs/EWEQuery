//
//  AnswerViewController.h
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/27/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Parse/Parse.h>

@interface AnswerViewController : PFQueryTableViewController

@property (nonatomic,strong) PFObject *question;

@end
