//
//  JMTabBarController.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/13.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMNavigationController.h"
#import "HangoutViewController.h"
#import "FriendsViewController.h"
#import "ProfileViewController.h"

@class JMNavigationController;
@interface JMTabBarController : UITabBarController

@property(nonatomic, strong)JMNavigationController *HangoutNav;
@property(nonatomic, strong)JMNavigationController *friendsNav;
@property(nonatomic, strong)JMNavigationController *profileNav;

@property(nonatomic, strong)HangoutViewController *HangoutVC;
@property(nonatomic, strong)FriendsViewController *FriendsVC;
@property(nonatomic, strong)ProfileViewController *ProfilesVC;

@property(nonatomic, assign)NSInteger iLastSelectedIndex;
@property(nonatomic, strong)NSTimer *noticeCountTimer;
@property(nonatomic, assign)BOOL tabBarHidden;

@end
