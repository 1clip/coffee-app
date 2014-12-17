//
//  NewActivityViewControllerV2.m
//  coffee
//
//  Created by wang xuan on 14-12-8.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "NewActivityViewControllerV2.h"
#import "ViewEnums.h"
#import "QuartzCore/QuartzCore.h"
#import "Placeholder.h"
#import "DataModels.h"
#import "HangoutHelper.h"
#import "UIHelper.h"

@interface NewActivityViewControllerV2 ()
{
    NSNumber<Optional>* currentHangoutId;
    Hangout<Optional>* currentHangout;
    HangoutHelper* hangoutHelper;
    User<Optional>*currentUser;
    Participator<Optional>* userParticipator;
}
@end


static NSMutableArray *memberListData;


@implementation NewActivityViewControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.activityView setBackgroundColor:[CoffeeUIColor GrayBackgroundColor]];
    self.activityView.type = iCarouselTypeCoverFlow2;
    
    if(![self isNewActivity])
    {
        [self LoadData];
    }
    
    [self InitDetailView];
    [self LoadFriendsView];
    
    
    UITapGestureRecognizer *tap =
       [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard:)];

    [self.view addGestureRecognizer:tap];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}



-(void) addNewFriend:(PlaceholderUser *) user
{
    if(memberListData == nil)
    {
        memberListData = [[NSMutableArray alloc] init];
    }
    [memberListData addObject:user];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) InitDetailView
{
    bool isNewActivity = [self isNewActivity];
    [self InitTextBox:self.descView ContentInText:isNewActivity ? nil : currentHangout.subject];
    [self InitTextBox:self.addressView ContentInText:isNewActivity ? nil : currentHangout.location];
    [self InitTextBox:self.dateView ContentInText:isNewActivity ? nil : [UIHelper DisplayHangoutDate:currentHangout.startTime]];
    [self InitTextBox:self.timeView ContentInText:isNewActivity ? nil : [UIHelper DisplayHangoutTime:currentHangout.startTime]];
    [self InitTextBox:self.durationView ContentInText:isNewActivity ? nil : [NSString stringWithFormat:@"%f", [currentHangout.endTime timeIntervalSinceDate:currentHangout.startTime]]];
    NSString *status = @"Accept";
    if(!isNewActivity)
    {
        if(userParticipator.state == [ParticipatorState Pending])
        {
            status = @"Pending";
        }
    }
    
    [self.descImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"NA_Desc_%@", status]]];
    [self.addressImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"NA_Location_%@", status]]];
    [self.dateImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"NA_Date_%@", status]]];
    [self.timeImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"NA_Time_%@", status]]];
    [self.durationImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"NA_Desc_%@", status]]];
    [self.addressButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"NA_Address_%@", status]] forState:UIControlStateNormal];
    [self.addFriendButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"NA_Add_%@", status]] forState:UIControlStateNormal];
}

-(void) InitTextBox:(UIView *) textView ContentInText:(NSString *) content
{
    if(content != nil)
    {
        for(UIView *subView in textView.subviews)
        {
            if([subView isKindOfClass:[UITextField class]])
            {
                [((UITextField *)subView) setText:content];
            }
        }
    }
    textView.layer.cornerRadius=8.0f;
    textView.layer.masksToBounds=YES;
    textView.layer.borderColor = [self GetCurrentColor].CGColor; // set color as you want.
    textView.layer.borderWidth = 1.0;

}

-(void) LoadData
{
    hangoutHelper = [[HangoutHelper alloc] init];
    currentHangout = [hangoutHelper GetHangoutDetails:currentHangoutId.longValue];
    
    currentUser = [hangoutHelper GetCurrentUser];
    userParticipator = [HangoutHelper FindParticipatorByUserId:currentHangout UserId:currentUser.id];
    NSLog(@"xqq %@ %@ %f", currentHangout.startTime, currentHangout.endTime, [currentHangout.endTime timeIntervalSinceDate:currentHangout.startTime]);
    [self.activityTitle setText:currentHangout.activity];
}

-(void) LoadHangout:(long) hangoutId
{
    currentHangoutId = [NSNumber numberWithLong:hangoutId];
}
-(void) LoadFriendsView
{
    [self.addressButton addTarget:self action:@selector(findAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.inviteFriend setTextColor:[CoffeeUIColor AddActivityFontColor]];
    [self.inviteFriendBorder setBackgroundColor:[CoffeeUIColor GrayBackgroundColor]];
    

    if(memberListData == nil)
    {
        PlaceholderUser *user = [PlaceholderUser alloc];
        user.userName = @"奥迪哥";
        user.avatorImage = @"Sample_Audi.jpg";

        memberListData = [[NSMutableArray alloc] init];
        [memberListData addObject:user];
    }
    
    
    [self.addFriendButton addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addLabel setTextColor:[self GetCurrentColor]];
    
    [self reloadMemberData];
    
}


//Swipe view
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return memberListData.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if(!view)
    {
        CGFloat height = self.addFriendButton.frame.size.height;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, height + 10, height)];
        CFAvatarView *avator = [[CFAvatarView alloc] initWithFrame:CGRectMake(5.0, -10, height, height)];
        PlaceholderUser *user = memberListData[index];
        [avator setImageWithURL:nil placeholderImage:[UIImage imageNamed:user.avatorImage]];
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(avator.frame.origin.x, avator.frame.origin.y + avator.frame.size.height + 10, height, 10)];
        [userLabel setText:user.userName];
        [userLabel setFont:[UIFont systemFontOfSize:10.0]];
        [userLabel setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:avator];
        [view addSubview:userLabel];
    }
    
    return view;
}

-(void) reloadMemberData
{
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint* constraint in self.inviteFriendView.constraints) {
        if (constraint.firstItem == self.inviteFriendView && constraint.firstAttribute == NSLayoutAttributeWidth){
            //NSLog(@"%@", constraint.firstAttribute);
            heightConstraint = constraint;
        }
    }
    heightConstraint.constant = MIN(300.0, 48 * (1 + memberListData.count));
    [self.swipeFriends reloadData];
    [self.view setNeedsLayout];

}

-(void) addFriendAction: (UIButton *) sender
{
    [self performSegueWithIdentifier:@"InviteFriends" sender:self];    
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return 7;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        CGFloat width = self.activityView.frame.size.width / 3.0;
        
        CGFloat hight = MIN(width, self.activityView.frame.size.height - 10);
        NSString *imageName = @"Activity_Coffee";
        switch(index)
        {
            case 0:
                imageName = @"Activity_Dinner";
                break;
            case 1:
                imageName = @"Activity_Coffee";
                break;
            case 2:
                imageName = @"Activity_Shopping";
                break;
            case 3:
                imageName = @"Activity_Shower";
                break;
            case 4:
                imageName = @"Activity_Movie";
                break;
            case 5:
                imageName = @"Activity_KTV";
                break;
        }
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, hight, hight)];
        
        [view setBackgroundColor:[self GetCurrentColor]];
        if(index != self.activityView.currentItemIndex)
        {
//            [view setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.08]];
        }
        
        [((UIImageView *)view) setImage: [UIImage imageNamed:imageName]];
    }
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}



- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    //[self.activityView scrollToItemAtIndex:self.activityView.currentItemIndex animated:YES];
    [self.activityView reloadData];
}

-(void) findAddress:(UIButton *) sender
{
    [self performSegueWithIdentifier:@"Location" sender:self];
}

-(void) cancelButtonClick:(UIButton *) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) okButtonClick:(UIButton *) sender
{
    if([self isNewActivity])
    {
        Hangout * hangout = [[Hangout alloc] init];
        hangout.id = arc4random_uniform(100000000);
        hangout.subject = self.descText.text;
        hangout.location = self.addressText.text;
    }
}

-(BOOL) isNewActivity
{
    return currentHangoutId == nil;
}

-(UIColor *)GetCurrentColor
{
    return  [self isNewActivity] ? [CoffeeUIColor AcceptColor] : [UIHelper GetBackgroundColorByParticateState:userParticipator.state];
}

- (void)resignKeyboard: (UITapGestureRecognizer *)sender
{
    [self.descText resignFirstResponder];
    [self.dateText resignFirstResponder];
    [self.addressText resignFirstResponder];
    [self.timeText resignFirstResponder];
    [self.durationText resignFirstResponder];
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
