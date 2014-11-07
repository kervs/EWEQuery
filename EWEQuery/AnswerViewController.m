//
//  AnswerViewController.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/27/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "AnswerViewController.h"
#import "AddQuestionView.h"
#import "CustomAnswerViewCell.h"

@interface AnswerViewController ()

@property (nonatomic, strong)UIBarButtonItem *addAnswerButton;
@property (nonatomic,strong)UIBarButtonItem *cancelButton;
@property (nonatomic,strong)NSString *className;
@property (nonatomic,strong)PFObject *currentLikedAnswer;

@end

@implementation AnswerViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // This table displays items in the Todo class
        self.className = @"Answer";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
        [self.navigationItem setHidesBackButton:YES animated:YES];
        
        
    }
    return self;
}
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    [query whereKey:@"questionPosted" equalTo:self.question];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[CustomAnswerViewCell class] forCellReuseIdentifier:@"cell"];
    
    _cancelButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed:)];
    self.navigationItem.leftBarButtonItem = _cancelButton;
    
    _addAnswerButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"idea"] style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = _addAnswerButton;
}

- (void)cancelButtonPressed:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addButtonPressed:(id) sender {
    AddQuestionView *addQuestionView = [[AddQuestionView alloc]init];
    addQuestionView.isAnswer = (bool *) YES;
    addQuestionView.question = self.question;
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:addQuestionView animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    CustomAnswerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.currentAnswer = object;
    

    return cell;
}

  

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self loadObjects];
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
