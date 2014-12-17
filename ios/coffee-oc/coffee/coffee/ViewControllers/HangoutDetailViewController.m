//
//  HangoutDetailViewController.m
//  coffee
//
//  Created by wang xuan on 14-11-27.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutDetailViewController.h"
#import "NewActivityViewControllerV2.h"
#import "UITableGridViewCell.h"
#import "ActivityReplyViewCell.h"
#import "ViewEnums.h"
#import "DataModels.h"
#import "HangoutHelper.h"
#import "UIHelper.h"

@implementation HangoutDetailViewController

HangoutHelper *hangoutHelper;
User* currentUser;
long currentHangoutId;
Hangout* currentHangout;
HangoutSummary* currentHangoutSummary;
Participator *participator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self LoadData];
    [self InitDetailView];
    [self InitActionView];
    [self InitStatusView];
    [self InitPostView];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.view layoutIfNeeded];
    [self.activityImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:[UIHelper MapActivePureImage:currentHangout.activity]]];
    
    _detailView.layer.masksToBounds = YES;
    _detailView.layer.cornerRadius = _detailView.frame.size.height / 2.0;
    
    [_avatorImageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:currentHangoutSummary.organizer.avatarInfo.imageUrl]];
    [_avatorImageView setBorderWidth:2.0];
    
}


-(void)viewDidAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) LoadData
{
    hangoutHelper = [[HangoutHelper alloc] init];
    currentHangout = [hangoutHelper GetHangoutDetails:currentHangoutId];
    currentHangoutSummary = [hangoutHelper GetHangoutSummaryById:currentHangoutId];
    currentUser = [hangoutHelper GetCurrentUser];
    participator = [HangoutHelper FindParticipatorByUserId:currentHangout UserId:currentUser.id];

}

-(void) LoadHangout:(long)hangoutId
{
    currentHangoutId = hangoutId;
}

-(void) InitDetailView
{
    [self.activityTitle setText:currentHangout.activity];
    [self.activityDetailView setBackgroundColor: currentHangoutSummary.state == [HangoutState Active] ? [UIHelper GetBackgroundColorByParticateState:participator.state] : [CoffeeUIColor OverdueColor]];
    [self.actionBorder setBackgroundColor:[CoffeeUIColor BlackColorForAlpha]];
    [self.avatorImageView setBorderColor:currentHangoutSummary.state == [HangoutState Active] ? [UIHelper GetBorderColorByParticateState:participator.state]: [CoffeeUIColor OverdueBorderColor]];
    [self.detailView setBackgroundColor:[CoffeeUIColor BlackColorForAlpha]];
    
    
    self.locationLabel.text = currentHangout.subject;
    self.locationLabel.numberOfLines = 2;
    
    self.firstButton.hidden = ![self CanTakeAction];
    [self.firstButton addTarget:self action:@selector(DetailView_ActionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.secondButton addTarget:self action:@selector(DetailView_AddressButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.thirdButton.hidden = ![self CanEditHangout];
    [self.thirdButton addTarget:self action:@selector(DetailView_EditButtonClick:) forControlEvents:UIControlEventTouchUpInside];


}

-(void) InitActionView
{
    if([self CanTakeAction])
    {
        [self setActionView:[UIHelper ConvertToParticipatorEnum:participator.state]];
    }
    else
    {
        [self hideActionView:NO];
    }
    
    [self.addressButton setBackgroundImage:[UIHelper FindAddressButtonImage:participator.state] forState:UIControlStateNormal];
    self.addressLabel.hidden = YES;
    self.addressButton.hidden = YES;
    [self.addressLabel setText:currentHangout.location];
    
}

-(void) InitStatusView
{
    [self.swipeView setBackgroundColor:[CoffeeUIColor GrayBackgroundColor]];
    self.swipeView.alignment = SwipeViewAlignmentEdge;
    self.swipeView.pagingEnabled = YES;
    self.swipeView.truncateFinalPage = YES;
}

-(void) InitPostView
{
    
    [self.postBackgroundView setBackgroundColor:[CoffeeUIColor GrayBackgroundColor]];
    [self.postAvator setImageWithURL:nil placeholderImage:[UIImage imageNamed:currentUser.avatarInfo.imageUrl]];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ActivityReplyView";
    ActivityReplyViewCell *cell = [self.activityStatusTableView  dequeueReusableCellWithIdentifier:identifier];
    if (cell != nil)
    {
        [cell.phoneImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Sample_Audi.jpg"]];
        [cell.content setText:@"吴母牛：赞！！"];
        [cell.time setText:@"10 mins ago"];
    }
    
    return  cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.activityStatusTableView deselectRowAtIndexPath:indexPath animated:YES];
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
    return currentHangout.participators.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        CGFloat height = self.leftButton.frame.size.height;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, height + 15.0, self.swipeView.frame.size.height)];
        [view setBackgroundColor:[CoffeeUIColor GrayBackgroundColor]];

        CFAvatarView *avator = [[CFAvatarView alloc] initWithFrame:CGRectMake(5.0, (self.swipeView.frame.size.height - height) / 2 - 5, height, height)];
        UIColor *bg = [UIColor whiteColor];
        
        Participator * par = currentHangout.participators[index];
        User *user = [hangoutHelper GetUserById:par.id];
        
        [avator setImageWithURL: nil placeholderImage:[UIImage imageNamed:par.avatarInfo.imageUrl] badgeImage:[UIHelper FindBadgeImageByStatus:par.state]];
        [avator setBorderColor:bg];
        [avator setBorderWidth:2.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(avator.frame.origin.x, avator.frame.origin.y + avator.frame.size.height + 2.5, height, 10)];
        [label setText:user.friendlyName];
        [label setFont:[UIFont systemFontOfSize:11]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:avator];
        [view addSubview:label];
    }
    
    return view;
}

#pragma mark -
#pragma mark Control events

-(void) ChangeParticipateState:(HangoutParticipatorState) action
{
    //Todo:Call api to update the particator state
    
    
    NSString *state;
    
    switch(action)
    {
        case Accept:
            [self.activityDetailView setBackgroundColor:[CoffeeUIColor AcceptColor]];
            [self.avatorImageView setBorderColor:[CoffeeUIColor AcceptBorderColor]];
            state = [ParticipatorState Accept];
            break;
        case Pending:
            [self.activityDetailView setBackgroundColor:[CoffeeUIColor PendingColor]];
            [self.avatorImageView setBorderColor:[CoffeeUIColor PendingBorderColor]];
            state = [ParticipatorState Pending];
            break;
        case Cancel:
            [self.activityDetailView setBackgroundColor:[CoffeeUIColor CancelColor]];
            [self.avatorImageView setBorderColor:[CoffeeUIColor CancelBorderColor]];
            state = [ParticipatorState Reject];
            break;
        case Unknown:
            break;
    }
    
    
    [HangoutHelper FindParticipatorByUserId:currentHangout UserId:currentUser.id].state = state;
    
    [self.addressButton setBackgroundImage:[UIImage imageNamed:@"AddressButton"] forState:UIControlStateNormal];
    [self hideActionView:YES];
}

-(void) ActionButtonClick:(UIButton *) sender
{
    HangoutParticipatorState state = sender.tag;
    [self ChangeParticipateState:state];
    [self.swipeView reloadData];
}


-(void) hideActionView:(BOOL) neddAnimations
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
    
    if(neddAnimations)
    {
        [UIView animateWithDuration:.5 animations:^{
            [self.swipeView layoutIfNeeded];
        }];
    }
    
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint* constraint in self.activityStatusTableView.constraints) {
        if (constraint.firstItem == self.activityStatusTableView && constraint.firstAttribute == NSLayoutAttributeHeight){
            //NSLog(@"%@", constraint.firstAttribute);
            heightConstraint = constraint;
        }
    }
    
    heightConstraint.constant = heightConstraint.constant + self.activityActionView.frame.size.height;
    [self.view setNeedsLayout];
}

-(void) expandActionView
{
    _activityActionView.hidden = NO;
    NSLayoutConstraint *topConstraint;
    for (NSLayoutConstraint* constraint in self.view.constraints) {
        if (constraint.firstItem == self.swipeView && constraint.secondItem == self.activityDetailView){
            topConstraint = constraint;
        }
    }
    
    NSLayoutConstraint *newTop = [NSLayoutConstraint constraintWithItem:self.swipeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.activityActionView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view removeConstraint:topConstraint];
    [self.view addConstraint:newTop];
    [UIView animateWithDuration:.5 animations:^{
        [self.swipeView layoutIfNeeded];
    }];
    
    
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint* constraint in self.activityStatusTableView.constraints) {
        if (constraint.firstItem == self.activityStatusTableView && constraint.firstAttribute == NSLayoutAttributeHeight){
            //NSLog(@"%@", constraint.firstAttribute);
            heightConstraint = constraint;
        }
    }
    
    heightConstraint.constant = heightConstraint.constant - self.activityActionView.frame.size.height;
    [self.view setNeedsLayout];

}

-(void) DetailView_AddressButtonClick:(UIButton *) sender
{
    [self displayActionContent:YES];
}

-(void) DetailView_ActionButtonClick:(UIButton *) sender
{
    [self setActionView:[UIHelper ConvertToParticipatorEnum:[HangoutHelper FindParticipatorByUserId:currentHangout UserId:currentUser.id].state]];
    [self displayActionContent:NO];
}

-(void) DetailView_EditButtonClick:(UIButton *) sender
{
    [self performSegueWithIdentifier:@"NewActivity" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"NewActivity"])
    {
        NewActivityViewControllerV2 * theSegue = segue.destinationViewController;
        [theSegue LoadHangout:currentHangoutId];
    }
}


-(void) displayActionContent: (bool) displayAddress
{
    if(self.activityActionView.hidden == YES)
    {
        [self expandActionView];
    }
    self.leftButton.hidden = displayAddress;
    self.leftLabel.hidden = displayAddress;
    self.rightButton.hidden = displayAddress;
    self.rightLabel.hidden = displayAddress;
    
    self.addressLabel.hidden = !displayAddress;
    self.addressButton.hidden = !displayAddress;

}

-(void) setActionButton:(UIButton*) button Title:(UILabel*) label Participate:(HangoutParticipatorState) state
{
    button.tag = state;
    switch(state)
    {
        case Accept:
            [button setImage:[UIImage imageNamed:@"Details_Accept_Big"] forState:UIControlStateNormal];
            [label setTextColor:[CoffeeUIColor AcceptColor]];
            [label setText:@"Accept"];
            break;
        case Pending:
            [button setImage:[UIImage imageNamed:@"Details_Pending_Big"] forState:UIControlStateNormal];
            [label setTextColor:[CoffeeUIColor PendingColor]];
            [label setText:@"Pending"];
            break;
        case Cancel:
            [button setImage:[UIImage imageNamed:@"Details_Cancel_Big"] forState:UIControlStateNormal];
            [label setTextColor:[CoffeeUIColor CancelColor]];
            [label setText:@"Cancel"];
            break;
        case Unknown:
            break;
    }

}

-(void) setActionView:(HangoutParticipatorState) hangoutState
{
    
    [self.leftButton addTarget:self action:@selector(ActionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(ActionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    HangoutParticipatorState leftState;
    HangoutParticipatorState rightState;
    switch(hangoutState)
    {
        case Accept:
            leftState = Pending;
            rightState = Cancel;
            break;
        case Pending:
            leftState = Accept;
            rightState = Cancel;
            break;
        case Cancel:
            leftState = Accept;
            rightState = Pending;
            break;
        case Unknown:
            break;
    }
    
    [self setActionButton:self.leftButton Title:self.leftLabel Participate:leftState];
    [self setActionButton:self.rightButton Title:self.rightLabel Participate:rightState];

}

-(bool) CanTakeAction
{
    return currentHangoutSummary.state == [HangoutState Active];
}

-(bool) CanEditHangout
{
    return [self CanTakeAction] && currentHangoutSummary.organizer.id == currentUser.id;
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
