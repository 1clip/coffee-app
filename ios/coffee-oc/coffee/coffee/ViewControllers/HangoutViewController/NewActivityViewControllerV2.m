//
//  NewActivityViewControllerV2.m
//  coffee
//
//  Created by wang xuan on 14-12-8.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "NewActivityViewControllerV2.h"
#import "Constants.h"
#import "QuartzCore/QuartzCore.h"
#import "Placeholder.h"


@interface NewActivityViewControllerV2 ()

@end


static NSMutableArray *memberListData;

@implementation NewActivityViewControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.activityView setBackgroundColor:[Constants NewActivityTableBackgroundColor]];
    self.activityView.type = iCarouselTypeCoverFlow2;
    
    [self InitTextBoxBorder:self.descView];
    [self InitTextBoxBorder:self.addressView];
    [self InitTextBoxBorder:self.dateView];
    [self InitTextBoxBorder:self.timeView];
    [self InitTextBoxBorder:self.durationView];
    
    [self LoadFriendsView];
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

-(void) InitTextBoxBorder:(UIView *) textView
{
    textView.layer.cornerRadius=8.0f;
    textView.layer.masksToBounds=YES;
    textView.layer.borderColor = [Constants OrangeBackgroundColor].CGColor; // set color as you want.
    textView.layer.borderWidth = 1.0;

}

-(void) LoadFriendsView
{
    [self.addressButton addTarget:self action:@selector(findAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.inviteFriend setTextColor:[Constants AddActivityFontColor]];
    [self.inviteFriendBorder setBackgroundColor:[Constants InviteFriendBorderColor]];
    

    if(memberListData == nil)
    {
        PlaceholderUser *user = [PlaceholderUser alloc];
        user.userName = @"奥迪哥";
        user.avatorImage = @"Sample_Audi.jpg";

        memberListData = [[NSMutableArray alloc] init];
        [memberListData addObject:user];
    }
    
    
    [self.addFriendButton addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addLabel setTextColor:[Constants OrangeBackgroundColor]];
    
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
        NSString *imageName = @"coffee-22";
        switch(index)
        {
            case 0:
                imageName = @"dinner-22";
                break;
            case 1:
                imageName = @"coffee-22";
                break;
            case 2:
                imageName = @"shopping-22";
                break;
            case 3:
                imageName = @"shower-22";
                break;
            case 4:
                imageName = @"movie-22";
                break;
            case 5:
                imageName = @"KTV-22";
                break;
                
                
        }

        NSLog(@"%f %f", width, hight);
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, hight, hight)];
        if(index == self.activityView.currentItemIndex)
        {
            [view setBackgroundColor:[Constants OrangeBackgroundColor]];
        }
        else
        {
            [view setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:175.0/255.0 blue:60.0/255.0 alpha:0.5]];
        }
        [((UIImageView *)view) setImage: [UIImage imageNamed:imageName]];
        //view.contentMode = UIViewContentModeCenter;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
