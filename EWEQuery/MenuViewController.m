//
//  MenuViewController.m
//  EWEQuery
//
//  Created by Kervins Valcourt on 11/6/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "MenuViewController.h"
#import "DataSource.h"

@interface MenuViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UIImageView *profilePic;
@property (nonatomic,strong) UITextView *aboutMe;
@property (nonatomic,strong) UIButton *doneButton;
@property (nonatomic,strong) UIBarButtonItem * editButton;
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,assign) CGPoint svos;
@property (nonatomic,strong) UISegmentedControl *sc;
@property (nonatomic,strong) UIImagePickerController *picker;

@end

@implementation MenuViewController
- (void)loadView {
    self.view = [[UIView alloc]init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _profilePic = [[UIImageView alloc]initWithFrame:CGRectMake(40, 70, 230, 200)];
    [[[PFUser currentUser] objectForKey:@"userImage"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            // image can now be set on a UIImageView
            _profilePic.image = image;
        }
    }];
   
    
    _picker = [[UIImagePickerController alloc]init];
    _picker.delegate = self;
    
    _aboutMe = [[UITextView alloc]initWithFrame:CGRectMake( 40, 280, 230, 100)];
    _aboutMe.backgroundColor  = [UIColor yellowColor];
    _aboutMe.delegate = self;
    _aboutMe.editable = NO;
    _aboutMe.text = [[PFUser currentUser] objectForKey:@"aboutMe"];
    
    
    _doneButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 390, 230, 40)];
    [_doneButton setTitle:@"done" forState:UIControlStateNormal];
    _doneButton.backgroundColor = [UIColor blueColor];
    [_doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _doneButton.hidden = YES;
    
    _editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonPressed:)];
    self.navigationItem.rightBarButtonItem = _editButton;

    
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, 320, 600)];
    _scroll.showsHorizontalScrollIndicator = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    
    
    
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Camera", @"Photos", nil];
    _sc = [[UISegmentedControl alloc] initWithItems:itemArray];
    _sc.frame = CGRectMake(60, 20, 200, 40);
    
    [_sc addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    _sc.hidden = YES;
    
    [_scroll addSubview:_sc];
    
    [_scroll addGestureRecognizer:tap];
    
    [self.view addSubview:_scroll];
    [_scroll addSubview:_profilePic];
    [_scroll addSubview:_aboutMe];
    [_scroll addSubview:_doneButton];
    [_scroll addGestureRecognizer:tap];
   
    
}

- (void)segmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        [_picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else if (segment.selectedSegmentIndex == 1) {
        [_picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [self presentViewController:_picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info  {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_profilePic setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    self.svos = _scroll.contentOffset;
    CGPoint pt;
    CGRect rc = [textView bounds];
    rc = [textView convertRect:rc toView:_scroll];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [_scroll setContentOffset:pt animated:YES];
    
}

-(void)dismissKeyboard {
    [_aboutMe resignFirstResponder];
    [_scroll setContentOffset:CGPointMake(0,0) animated:YES];
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {

    [_scroll setContentOffset:CGPointMake(0,0) animated:YES];
    [textView resignFirstResponder];
    return YES;
}

- (void) editButtonPressed: (id)sender {
    _doneButton.hidden = NO;
     _aboutMe.editable = YES;
    _sc.hidden = NO;
}

- (void) doneButtonPressed: (id)sender {
    
    [_scroll setContentOffset:CGPointMake(0,0) animated:YES];
    _doneButton.hidden = YES;
    _sc.hidden = YES;
    [_aboutMe resignFirstResponder];
    DataSource *newUserInfo = [[DataSource alloc]init];
    [newUserInfo userImage:_profilePic.image userAboutMe:_aboutMe.text];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
