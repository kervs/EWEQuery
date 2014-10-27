//
//  AddQuestionView.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/21/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "AddQuestionView.h"
#import "DataSource.h"

@interface AddQuestionView()

@property (nonatomic, strong)UIView *addQuestionView;
@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, strong)UIButton *addButton;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *instructionLabel;
@property (nonatomic, strong)UITextView *inputText;

@end

@implementation AddQuestionView

- (void)loadView {
    [super loadView];
    
    self.view = [UIView new];
    self.view.backgroundColor = [UIColor clearColor];
    self.addQuestionView = [[UIView alloc] init];
    self.addQuestionView.frame = CGRectMake(20, 80, 280, 300);
    self.addQuestionView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_addQuestionView];
    
    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 60, 30)];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(self.addQuestionView.bounds.size.width - 80, 20, 60, 30)];
    [self.addButton setTitle:@"Post" forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(postedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.inputText = [[UITextView alloc]initWithFrame:CGRectMake(0, 50, 280, self.addQuestionView.bounds.size.height - 90)];
    self.inputText.backgroundColor = [UIColor whiteColor];
    [self.inputText setFont:[UIFont systemFontOfSize:18]];
    self.inputText.textAlignment = NSTextAlignmentLeft;
    
    if (self.isAnswer) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 17, 60, 30)];
        self.titleLabel.text = @"Answer";
        self.titleLabel.font = [UIFont fontWithName:@"Cochin-BoldItalic" size:17];
    } else {
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 17, 60, 30)];
    self.titleLabel.text = @"Query";
    self.titleLabel.font = [UIFont fontWithName:@"Cochin-BoldItalic" size:22];
    }
    
    self.instructionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.inputText.frame) + 5,self.addQuestionView.bounds.size.width , 20)];
    self.instructionLabel.text = @" Example: EWEQuery is the Best!!";
    self.instructionLabel.textColor = [UIColor  lightGrayColor];
    self.instructionLabel.backgroundColor = [UIColor whiteColor];
   
    
    
    [self.addQuestionView addSubview:self.cancelButton];
    [self.addQuestionView addSubview:self.addButton];
    [self.addQuestionView addSubview:self.inputText];
    [self.addQuestionView addSubview:self.titleLabel];
    [self.addQuestionView addSubview:self.instructionLabel];
    
}

- (void)cancelButtonPressed:(id) sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)postedButtonPressed:(id) sender {
    DataSource *newQestion = [[DataSource alloc]init];
    if (self.isAnswer) {
        [newQestion postAnswer:self.inputText.text answerBy:[PFUser currentUser] toThisQuestion:self.question];
    } else{
    [newQestion postQuery:self.inputText.text andPost:[PFUser currentUser]];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void) viewDidLoad {
    [super viewDidLoad];
    self.addQuestionView.layer.cornerRadius = 15;
}


@end
