//
//  HangoutDetailViewController.m
//  coffee
//
//  Created by wang xuan on 14-11-27.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutDetailViewController.h"
#import "UITableGridViewCell.h"
#import "ActivityReplyViewCell.h"
#import "Constants.h"


@implementation HangoutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self.activityDetailView setBackgroundColor:[Constants OrangeBackgroundColor]];
    [self.actionBorder setBackgroundColor:[Constants OrangeFrontendColor]];
    [self.avatorImageView setBorderColor:[Constants OrangeBorderColor]];
    [self.activityImage setBackgroundColor:[Constants OrangeFrontendColor]];
    [self.detailView setBackgroundColor:[Constants OrangeFrontendColor]];
    [self.addressButton setBackgroundImage:[UIImage imageNamed:@"Address_Pending"] forState:UIControlStateNormal];
    
    [self.swipeView setBackgroundColor:[Constants StatusTableBackgroundColor]];
    self.swipeView.alignment = SwipeViewAlignmentEdge;
    self.swipeView.pagingEnabled = YES;
    self.swipeView.truncateFinalPage = YES;
    
    [self.postBackgroundView setBackgroundColor:[Constants StatusTableBackgroundColor]];
    [self.postAvator setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Sample_Rae.jpg"]];
    
    
    self.leftButton.tag = 1;
    [self.leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftLabel setTextColor:[Constants GreenBackgroundColor]];
    
    self.rightButton.tag = 1;
    [self.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightLabel setTextColor:[Constants RedBackgroundColor]];
    
    
    
    self.addressLabel.hidden = YES;
    self.addressButton.hidden = YES;
    [self.addressLabel setText:@"Zizhu Campus Building 01\nNo.999 Zixing Road, China"];
    
    
    [self.firstButton addTarget:self action:@selector(actionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.secondButton addTarget:self action:@selector(addressButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.thirdButton addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)viewWillAppear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.view layoutIfNeeded];
    [self.activityImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Dinner_Big"]];
    
    
    _detailView.layer.masksToBounds = YES;
    _detailView.layer.cornerRadius = _detailView.frame.size.height / 2.0;
    
    
    _locationLabel.text = @"Today is my Birthday!\nLet's have dinner";
    _locationLabel.textColor = [UIColor whiteColor];
    _locationLabel.backgroundColor = [UIColor clearColor];
    _locationLabel.font = [UIFont systemFontOfSize:10];
    _locationLabel.textAlignment = NSTextAlignmentLeft;
    _locationLabel.numberOfLines = 2;
    
    [_avatorImageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Sample_Rae.jpg"]];
    [_avatorImageView setBorderWidth:2.0];
    
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
        CGFloat height = self.leftButton.frame.size.height;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, height + 15.0, self.swipeView.frame.size.height)];
        [view setBackgroundColor:[Constants StatusTableBackgroundColor]];

        CFAvatarView *avator = [[CFAvatarView alloc] initWithFrame:CGRectMake(5.0, (self.swipeView.frame.size.height - height) / 2 - 5, height, height)];
        UIColor *bg = [UIColor whiteColor];
        NSString *imageName = @"Sample_Audi";
        NSString *badgeName = @"Deatails_Accept";
        NSString *userName = @"奥迪哥";
        switch(index)
        {
            case 0:
                imageName = @"Sample_Rae.jpg";
                badgeName = @"Details_Accept";
                userName = @"瑞娥";
                break;
            case 1:
                imageName = @"Sample_Audi.jpg";
                badgeName = @"Details_Accept";
                userName = @"奥迪哥";
                break;
            case 2:
                imageName = @"Sample_Achie.jpg";
                badgeName = @"Details_Accept";
                userName = @"阿屌丝";
                break;
            case 3:
                imageName = @"Sample_Sofang.jpg";
                badgeName = @"Details_Pending";
                userName = @"方圆";
                break;
            case 4:
                imageName = @"Sample_Glass.jpg";
                badgeName = @"Details_Pending";
                userName = @"So姐姐";
                break;
            case 5:
                imageName = @"xiaowu";
                badgeName = @"Details_Cancel";
                userName = @"吴母牛";
                break;
        }
        [avator setImageWithURL: nil placeholderImage:[UIImage imageNamed:imageName] badgeImage:[UIImage imageNamed:badgeName]];
        [avator setBorderColor:bg];
        [avator setBorderWidth:2.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(avator.frame.origin.x, avator.frame.origin.y + avator.frame.size.height + 2.5, height, 10)];
        [label setText:userName];
        [label setFont:[UIFont systemFontOfSize:11]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:avator];
        [view addSubview:label];
    }
    
    return view;
}

#pragma mark -
#pragma mark Control events

- (void)takeAction: (UITapGestureRecognizer *)sender
{
    /*CGPoint touchPoint = [sender locationInView:_activityActionView];
    if(touchPoint.x >= self.acceptActionButtonView.frame.origin.x && touchPoint.x <= self.acceptActionButtonView.frame.origin.x + self.acceptActionButtonView.frame.size.width && touchPoint.y >= self.acceptActionButtonView.frame.origin.y && touchPoint.y <= self.acceptActionButtonView.frame.origin.y + self.acceptActionButtonView.frame.size.height)
    {
        //[self.statusImageView setImage:[UIImage imageNamed:@"cancel_white-22"]];
        [self.activityDetailView setBackgroundColor:[Constants RedBackgroundColor]];
        [self.activityImage setBackgroundColor:[Constants RedFrontendColor]];
        [self.avatorImageView setBorderColor:[Constants RedBorderColor]];
        [self.detailView setBackgroundColor:[Constants RedFrontendColor]];
        [self hideActionView];
    }
    
    if(touchPoint.x >= self.cancelActionButtonView.frame.origin.x && touchPoint.x <= self.cancelActionButtonView.frame.origin.x + self.cancelActionButtonView.frame.size.width && touchPoint.y >= self.cancelActionButtonView.frame.origin.y && touchPoint.y <= self.cancelActionButtonView.frame.origin.y + self.cancelActionButtonView.frame.size.height)
    {
        //[self.statusImageView setImage:[UIImage imageNamed:@"cancel_white-22"]];
        [self.activityDetailView setBackgroundColor:[Constants GrayBackgroundColor]];
        [self.activityImage setBackgroundColor:[Constants GrayFrontendColor]];
        [self.detailView setBackgroundColor:[Constants GrayFrontendColor]];
        [self.avatorImageView setBorderColor:[Constants GrayBorderColor]];
        [self hideActionView];
    }*/
}

-(void) leftButtonAction:(UIButton *) sender
{
    if(self.leftButton.tag == 1) //accept
    {
        [self.activityDetailView setBackgroundColor:[Constants GreenBackgroundColor]];
        [self.activityImage setBackgroundColor:[Constants GreenFrontendColor]];
        [self.avatorImageView setBorderColor:[Constants GreenBorderColor]];
        [self.detailView setBackgroundColor:[Constants GreenFrontendColor]];
        [self.actionBorder setBackgroundColor:[Constants GreenFrontendColor]];
        
        [self.addressButton setBackgroundImage:[UIImage imageNamed:@"AddressButton"] forState:UIControlStateNormal];
        [self hideActionView];

    }
}

-(void) rightButtonAction:(UIButton *) sender
{
    if(self.rightButton.tag == 1) //cancel
    {
        [self.activityDetailView setBackgroundColor:[Constants RedBackgroundColor]];
        [self.activityImage setBackgroundColor:[Constants RedFrontendColor]];
        [self.avatorImageView setBorderColor:[Constants RedBorderColor]];
        [self.detailView setBackgroundColor:[Constants RedFrontendColor]];
        [self.actionBorder setBackgroundColor:[Constants RedFrontendColor]];
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

-(void) addressButtonAction:(UIButton *) sender
{
    [self displayActionContent:YES];
}

-(void) actionButtonAction:(UIButton *) sender
{
    [self displayActionContent:NO];
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

-(void) editButtonAction:(UIButton *) sender
{
    [self performSegueWithIdentifier:@"NewActivity" sender:self];
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
