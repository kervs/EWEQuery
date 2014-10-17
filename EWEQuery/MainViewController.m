//
//  MainViewController.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 10/16/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "MainViewController.h"
#import <CoreData/CoreData.h>
#import <Parse/Parse.h>
#import <FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
@interface MainViewController () <UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong)UINavigationBar *navBar;
@property (nonatomic, strong)UIButton *addNoteButton;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,strong)NSFetchedResultsController *fetchedResultsController;

@end

@implementation MainViewController

- (void)loadView {
    self.view = [[UIView alloc]init];
    CGFloat width = self.view.frame.size.width;
    
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,width,64)];
    _navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.navBar.backgroundColor = [UIColor lightGrayColor];
    self.tableView = [UITableView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_navBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 160, 40)];
    title.text = @"EWEQuery";
    title.font = [UIFont fontWithName:@"Cochin-BoldItalic" size:24];
    
    [self.navBar addSubview:title];
    
    
    
}

-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat width = self.view.frame.size.width;
    self.tableView.frame = CGRectMake(0, 64, width, self.view.frame.size.height);
    
}

#pragma mark- TableView

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        //create a cell only if one couldn't be reused
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
    
}


@end
