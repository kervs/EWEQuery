//
//  TestMainViewController.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/23/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//
#import "AddQuestionView.h"
#import "AnswerViewController.h"
#import "TestMainViewController.h"
#import "CustomMainViewCell.h"
#import "MenuViewController.h"
@interface TestMainViewController ()
@property (nonatomic, strong)UIBarButtonItem *addNoteButton;
@property (nonatomic, strong)UIBarButtonItem *menuButton;
@property (nonatomic,strong)UIBarButtonItem *exitButton;
@property (nonatomic,strong)NSString *className;

@end

@implementation TestMainViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // This table displays items in the Todo class
        self.className = @"Query";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
        [self.navigationItem setHidesBackButton:YES animated:YES];
        
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    
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
    [self.tableView registerClass:[CustomMainViewCell class] forCellReuseIdentifier:@"cell"];

   
   self.title = @"EWEQuery";
    

    _exitButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"exit"] style:UIBarButtonItemStylePlain target:self action:@selector(exitButtonPressed:)];
    self.navigationItem.leftBarButtonItem = _exitButton;
    
    _addNoteButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"idea"] style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed:)];
     _menuButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: _menuButton,_addNoteButton, nil];

    
    
}

- (void)exitButtonPressed:(id) sender {
    [PFUser logOut];
   [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)menuButtonPressed:(id) sender {
    
    MenuViewController *menuView = [[MenuViewController alloc]init];
    [self.navigationController pushViewController:menuView animated:YES];
    
}

- (void)addButtonPressed:(id) sender {
    AddQuestionView *addQuestionView = [[AddQuestionView alloc]init];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:addQuestionView animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    
    CustomMainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.smileyFace.image = [UIImage imageNamed:@"happy"];
    
    cell.questionAsk.text = [object objectForKey:@"query"];
    
    PFQuery *qry = [PFQuery queryWithClassName:@"Answer"];
    [qry whereKey:@"questionPosted" equalTo:object];

    [qry countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        // count tells you how many objects matched the query
        cell.numberOfAnswers.text = [NSString stringWithFormat:@"%i answer",count];
        
        if (count <= 1) {
            cell.indicatorOfInterest.image = [UIImage imageNamed:@"fire1"];
        } else if (count > 1 && count < 3) {
            cell.indicatorOfInterest.image = [UIImage imageNamed:@"fire2"];
        } else{
            cell.indicatorOfInterest.image = [UIImage imageNamed:@"fire3"];
        }
    }];
    

    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    AnswerViewController *showAnswer = [[AnswerViewController alloc]init];
    showAnswer.question = object;
    [self.navigationController pushViewController:showAnswer animated:YES];
    
    
    
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
