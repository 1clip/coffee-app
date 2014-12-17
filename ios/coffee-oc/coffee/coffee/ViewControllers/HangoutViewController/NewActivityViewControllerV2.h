//
//  NewActivityViewControllerV2.h
//  coffee
//
//  Created by wang xuan on 14-12-8.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "Trapezoid.h"
#import "Trapezoid1.h"
#import "ICarousel.h"
#import "CFAvatarView.h"
#import "Placeholder.h"

@interface NewActivityViewControllerV2 : UIViewController<iCarouselDataSource, iCarouselDelegate, SwipeViewDelegate, SwipeViewDelegate>

@property(nonatomic, weak) IBOutlet UIButton *acceptButton;
@property(nonatomic, weak) IBOutlet UIButton *cancelButton;

@property(nonatomic, weak) IBOutlet iCarousel* activityView;

@property(nonatomic, weak) IBOutlet UIView *descView;
@property(nonatomic, weak) IBOutlet UIImageView *descImage;
@property(nonatomic, weak) IBOutlet UITextField *descText;
@property(nonatomic, weak) IBOutlet UIView *addressView;
@property(nonatomic, weak) IBOutlet UIImageView *addressImage;
@property(nonatomic, weak) IBOutlet UITextField *addressText;
@property(nonatomic, weak) IBOutlet UIView *dateView;
@property(nonatomic, weak) IBOutlet UIImageView *dateImage;
@property(nonatomic, weak) IBOutlet UITextField *dateText;
@property(nonatomic, weak) IBOutlet UIView *timeView;
@property(nonatomic, weak) IBOutlet UIImageView *timeImage;
@property(nonatomic, weak) IBOutlet UITextField *timeText;
@property(nonatomic, weak) IBOutlet UIView *durationView;
@property(nonatomic, weak) IBOutlet UIImageView *durationImage;
@property(nonatomic, weak) IBOutlet UITextField *durationText;
@property(nonatomic, weak) IBOutlet UIButton *addressButton;


@property(nonatomic, weak) IBOutlet UILabel *inviteFriend;
@property(nonatomic, weak) IBOutlet UIView *inviteFriendBorder;
@property(nonatomic, weak) IBOutlet UIButton *addFriendButton;
@property(nonatomic, weak) IBOutlet UIView *inviteFriendView;
@property(nonatomic, weak) IBOutlet SwipeView *swipeFriends;
@property(nonatomic, weak) IBOutlet UILabel *addLabel;

@property(nonatomic, strong) IBOutlet UILabel *activityTitle;

-(void) addNewFriend:(PlaceholderUser *) user;

-(void) LoadHangout:(long) hangoutId;

@end
