//
//  AppDelegate.h
//  JoinMeDemo
//
//  Created by lixin on 14/11/13.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong)JMTabBarController *tabBarController;
@property(nonatomic, strong)UINavigationController *tabBarNav;

@end

