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

@interface NewActivityViewControllerV2 : UIViewController<iCarouselDataSource, iCarouselDelegate>

@property(nonatomic, weak) IBOutlet UIButton *acceptButton;
@property(nonatomic, weak) IBOutlet UIButton *cancelButton;

@property(nonatomic, weak) IBOutlet iCarousel* activityView;

@property(nonatomic, weak) IBOutlet UIView *descView;
@property(nonatomic, weak) IBOutlet UIView *addressView;
@property(nonatomic, weak) IBOutlet UIView *dateView;
@property(nonatomic, weak) IBOutlet UIView *timeView;


@property(nonatomic, weak) IBOutlet UILabel *inviteFriend;
@property(nonatomic, weak) IBOutlet UIView *inviteFriendBorder;


@property(nonatomic, weak) IBOutlet CFAvatarView *avatorView;
@property(nonatomic, weak) IBOutlet UIButton *addFriendButton;


@end
