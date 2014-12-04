//
//  HangoutDetailViewController.m
//  coffee
//
//  Created by wang xuan on 14-11-27.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutDetailViewController.h"
#import "UITableGridViewCell.h"
#import "ActivityReplyView.h"


@implementation HangoutDetailViewController

@synthesize activityImage = _activityImage;
@synthesize _detailView;
@synthesize _activityDetailView;
@synthesize avatorImageView = _avatorImageView;
@synthesize _acceptActionButtonView;
@synthesize _cancelActionButtonView;
@synthesize activityStatusTableView = _activityStatusTableView;
@synthesize swipeView = _swipeView;
@synthesize activityActionView = _activityActionView;
@synthesize locationLabel = _locatonLabel;
@synthesize lbsView = _lbsView;
@synthesize statusImageView = _statusImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    
    [self._activityDetailView setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:206.0/255.0 blue:180.0/255.0 alpha:1.0]];
    
    _locatonLabel.text = @"Time: 7:00pm Today \n Restaurant: Yun Tun";
    _locatonLabel.textColor = [UIColor whiteColor];
    _locatonLabel.backgroundColor = [UIColor clearColor];
    _locatonLabel.font = [UIFont systemFontOfSize:10];
    _locatonLabel.textAlignment = NSTextAlignmentCenter;
    _locatonLabel.numberOfLines = 2;
    
    [_lbsView setImage:[UIImage imageNamed:@"icon_lbs_28_n"]];
    
    [_avatorImageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"xiaowu"]];
    [_avatorImageView setBorderWidth:2.0];
    UIColor *borderColor = [UIColor colorWithRed:128.0/255.0 green:223.0/255.0 blue:209.0/255.0 alpha:1.0];
    [_avatorImageView setBorderColor:borderColor];

    
    [self._acceptActionButtonView setImage:[UIImage imageNamed:@"accept"]];
    [self._cancelActionButtonView setImage:[UIImage imageNamed:@"cancel-22"]];
    
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeAction:)];
    
    [_activityActionView addGestureRecognizer: tap];
    
    
    [swipeView setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    swipeView.alignment = SwipeViewAlignmentEdge;
    swipeView.pagingEnabled = YES;
    swipeView.truncateFinalPage = YES;

}

- (void)viewDidLayoutSubviews {
    [self.activityImage setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:185.0/255.0 blue:162.0/255.0 alpha:1.0]];
    [self.activityImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"dinner"]];
}

-(void)viewWillAppear:(BOOL)animated {//    [self.activityImage setImageWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"dinner" ofType:@"png"]]];
    

}


-(void)viewDidAppear:(BOOL)animated{

    
    _detailView.layer.masksToBounds = YES;
    _detailView.layer.cornerRadius = _detailView.frame.size.height / 2.0;
    [_detailView setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:185.0/255.0 blue:162.0/255.0 alpha:1.0]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initTableView{
    self.activityStatusTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.activityStatusTableView.separatorColor = [UIColor lightGrayColor];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableGridViewCell *cell = [_activityStatusTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableGridViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ActivityReplyView *view = [[ActivityReplyView alloc] initWithFrame:CGRectMake(0, 0, _activityStatusTableView.frame.size.width, 35)];
        [cell addSubview:view];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //不让tableviewcell有选中效果
    NSLog(@"selectd row =%ld",indexPath.row);
    [self.activityStatusTableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)dealloc
{
    swipeView.delegate = nil;
    swipeView.dataSource = nil;
    _activityStatusTableView.dataSource = nil;
    _activityStatusTableView.delegate = nil;
}

//Swipe view
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return 100;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        CGFloat height = self._acceptActionButtonView.frame.size.height * 1.1;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, height + 15.0, self.swipeView.frame.size.height)];
        [view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        //if(index % 2 == 0)
        //[view setBackgroundColor:[UIColor redColor]];
        CFAvatarView *avator = [[CFAvatarView alloc] initWithFrame:CGRectMake(5.0, (self.swipeView.frame.size.height - height) / 2, height, height)];
        UIColor *bg = [UIColor whiteColor];
        [avator setImageWithURL: nil placeholderImage:[UIImage imageNamed:@"xiaowu"] badgeImage:[UIImage imageNamed:@"accept"]];
        [avator setBorderColor:bg];
        [avator setBorderWidth:2.0];
        [view addSubview:avator];
    }
    
    return view;
}

#pragma mark -
#pragma mark Control events

- (IBAction)pressedButton:(id)sender
{
    //_label.text = [NSString stringWithFormat:@"Button %ld pressed", [_activityMemberView indexOfItemViewOrSubview:sender]];
}

- (IBAction)toggledSwitch:(id)sender
{
    //_label.text = [NSString stringWithFormat:@"Switch %ld toggled", [_activityMemberView indexOfItemViewOrSubview:sender]];
}

- (IBAction)changedSlider:(id)sender
{
    //_label.text = [NSString stringWithFormat:@"Slider %ld changed", [_activityMemberView indexOfItemViewOrSubview:sender]];
}

- (void)takeAction: (UITapGestureRecognizer *)sender
{
    CGPoint touchPoint = [sender locationInView:_activityActionView];
    if(touchPoint.x >= self._acceptActionButtonView.frame.origin.x && touchPoint.x <= self._acceptActionButtonView.frame.origin.x + self._acceptActionButtonView.frame.size.width && touchPoint.y >= self._acceptActionButtonView.frame.origin.y && touchPoint.y <= self._acceptActionButtonView.frame.origin.y + self._acceptActionButtonView.frame.size.height)
    {
        
        self.statusImageView.hidden = NO;
        
        [self.statusImageView setImage:[UIImage imageNamed:@"cancel_white-22"]];
        
        [self._activityDetailView setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:67.0/255.0 blue:76.0/255.0 alpha:1.0]];
        [self.activityImage setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:60.0/255.0 blue:68.0/255.0 alpha:1.0]];
        
        
        [self._detailView setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:60.0/255.0 blue:68.0/255.0 alpha:1.0]];
        
        [self hideActionView];
    }
    
    if(touchPoint.x >= self._cancelActionButtonView.frame.origin.x && touchPoint.x <= self._cancelActionButtonView.frame.origin.x + self._cancelActionButtonView.frame.size.width && touchPoint.y >= self._cancelActionButtonView.frame.origin.y && touchPoint.y <= self._cancelActionButtonView.frame.origin.y + self._cancelActionButtonView.frame.size.height)
    {
        
        self.statusImageView.hidden = NO;
        
        [self.statusImageView setImage:[UIImage imageNamed:@"cancel_white-22"]];
        
        [self._activityDetailView setBackgroundColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
        [self.activityImage setBackgroundColor:[UIColor colorWithRed:91.0/255.0 green:91.0/255.0 blue:91.0/255.0 alpha:1.0]];
        
        
        [self._detailView setBackgroundColor:[UIColor colorWithRed:91.0/255.0 green:91.0/255.0 blue:91.0/255.0 alpha:1.0]];
        
        [self hideActionView];
    }
}

-(void) hideActionView
{
    _activityActionView.hidden = YES;
    NSLayoutConstraint *topConstraint;
    for (NSLayoutConstraint* constraint in self.view.constraints) {
        if (constraint.firstItem == self.swipeView && constraint.secondItem == self.activityActionView){
            topConstraint = constraint;        }
        
        //NSLog(@"%ld %ld", constraint.firstAttribute, constraint.firstAttribute);
    }
    NSLayoutConstraint *newTop = [NSLayoutConstraint constraintWithItem:self.swipeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self._activityDetailView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view removeConstraint:topConstraint];
    [self.view addConstraint:newTop];
    [UIView animateWithDuration:.5 animations:^{
        [self.swipeView layoutIfNeeded];
    }];
    
    
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint* constraint in self.view.constraints) {
        if (constraint.firstItem == self.activityStatusTableView && constraint.secondItem == self.view
            && constraint.firstAttribute == NSLayoutAttributeHeight){
            heightConstraint = constraint;
            NSLog(@"%ld %f", constraint.firstAttribute, constraint.multiplier);
        }
    }
    
    heightConstraint.constant = self.activityActionView.frame.size.height;
    
    [self.view setNeedsLayout];


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
