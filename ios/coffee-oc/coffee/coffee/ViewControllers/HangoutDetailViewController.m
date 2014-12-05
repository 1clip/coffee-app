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
#import "Constants.h"


@implementation HangoutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self.activityDetailView setBackgroundColor:[Constants GreenBackgroundColor]];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeAction:)];
    
    [self.activityActionView addGestureRecognizer: tap];
    
    [self.swipeView setBackgroundColor:[Constants StatusTableBackgroundColor]];
    self.swipeView.alignment = SwipeViewAlignmentEdge;
    self.swipeView.pagingEnabled = YES;
    self.swipeView.truncateFinalPage = YES;

}

-(void)viewWillAppear:(BOOL)animated {
    [self.view layoutIfNeeded];
    [self.activityImage setBackgroundColor:[Constants GreenFrontendColor]];
    [self.activityImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"dinner"]];
    
    
    _detailView.layer.masksToBounds = YES;
    _detailView.layer.cornerRadius = _detailView.frame.size.height / 2.0;
    [_detailView setBackgroundColor:[Constants GreenFrontendColor]];
    
    
    _locationLabel.text = @"Time: 7:00pm Today \n Restaurant: Yun Tun";
    _locationLabel.textColor = [UIColor whiteColor];
    _locationLabel.backgroundColor = [UIColor clearColor];
    _locationLabel.font = [UIFont systemFontOfSize:10];
    _locationLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.numberOfLines = 2;
    
    [_avatorImageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"xiaowu"]];
    [_avatorImageView setBorderWidth:2.0];
    [_avatorImageView setBorderColor:[Constants GreenBorderColor]];
}


-(void)viewDidAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initTableView{
    self.activityStatusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
}


- (void)dealloc
{
    self.swipeView.delegate = nil;
    self.swipeView.dataSource = nil;
    self.activityStatusTableView.dataSource = nil;
    self.activityStatusTableView.delegate = nil;
}

//Swipe view
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return 6;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        CGFloat height = self.acceptActionButtonView.frame.size.height * 1.1;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, height + 15.0, self.swipeView.frame.size.height)];
        [view setBackgroundColor:[Constants StatusTableBackgroundColor]];

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

- (void)takeAction: (UITapGestureRecognizer *)sender
{
    CGPoint touchPoint = [sender locationInView:_activityActionView];
    if(touchPoint.x >= self.acceptActionButtonView.frame.origin.x && touchPoint.x <= self.acceptActionButtonView.frame.origin.x + self.acceptActionButtonView.frame.size.width && touchPoint.y >= self.acceptActionButtonView.frame.origin.y && touchPoint.y <= self.acceptActionButtonView.frame.origin.y + self.acceptActionButtonView.frame.size.height)
    {
        [self.statusImageView setImage:[UIImage imageNamed:@"cancel_white-22"]];
        [self.activityDetailView setBackgroundColor:[Constants RedBackgroundColor]];
        [self.activityImage setBackgroundColor:[Constants RedFrontendColor]];
        [self.avatorImageView setBorderColor:[Constants RedBorderColor]];
        [self.detailView setBackgroundColor:[Constants RedFrontendColor]];
        [self hideActionView];
    }
    
    if(touchPoint.x >= self.cancelActionButtonView.frame.origin.x && touchPoint.x <= self.cancelActionButtonView.frame.origin.x + self.cancelActionButtonView.frame.size.width && touchPoint.y >= self.cancelActionButtonView.frame.origin.y && touchPoint.y <= self.cancelActionButtonView.frame.origin.y + self.cancelActionButtonView.frame.size.height)
    {
        [self.statusImageView setImage:[UIImage imageNamed:@"cancel_white-22"]];
        [self.activityDetailView setBackgroundColor:[Constants GrayBackgroundColor]];
        [self.activityImage setBackgroundColor:[Constants GrayFrontendColor]];
        [self.detailView setBackgroundColor:[Constants GrayFrontendColor]];
        [self.avatorImageView setBorderColor:[Constants GrayBorderColor]];
        [self hideActionView];
    }
}

-(void) hideActionView
{
    _activityActionView.hidden = YES;
    NSLayoutConstraint *topConstraint;
    for (NSLayoutConstraint* constraint in self.view.constraints) {
        if (constraint.firstItem == self.swipeView && constraint.secondItem == self.activityActionView){
            topConstraint = constraint;
        }
    }
    
    NSLayoutConstraint *newTop = [NSLayoutConstraint constraintWithItem:self.swipeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.activityDetailView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
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
