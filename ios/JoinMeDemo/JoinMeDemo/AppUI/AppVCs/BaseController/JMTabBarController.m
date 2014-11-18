//
//  JMTabBarController.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/13.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import "JMTabBarController.h"
#import "AppDef.h"

@interface JMTabBarController ()<UITabBarControllerDelegate>{
}

@end

@implementation JMTabBarController

- (id)init
{
  self = [super init];
  if (self) {
    // Custom initialization
    BOOL bIO7 = isRunningOnIOS7;
    if (bIO7) {
      self.tabBar.barStyle = UIBarStyleDefault;
      [self.tabBar setOpaque:YES];
      [self.tabBar setTranslucent:YES];
      [self.tabBar setClipsToBounds:YES];
      
      UINavigationBar* appearanceNavigationBar = [UINavigationBar appearance];
      if ([[UINavigationBar class] instancesRespondToSelector:@selector(setBackIndicatorImage:)]){
        appearanceNavigationBar.backIndicatorImage = [UIImage imageNamed:@"icon_message_return_gray"];
        appearanceNavigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"icon_message_return_gray"];
        appearanceNavigationBar.tintColor = PDColorBarTitleColorDefault;
      }
    }
    else{
      UINavigationBar* appearanceNavigationBar = [UINavigationBar appearance];
      if([[UINavigationBar class] instancesRespondToSelector:@selector(setTintColor:)]){
        [appearanceNavigationBar setTintColor:PDColorBarBgColorDefault];
      }
      [[UITabBar appearance] setTintColor:[UIColor colorWithRGBHex:0xfafafa]];
      [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage alloc] init]];
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor colorWithRGBHex:0x7f7e80],
                                                        UITextAttributeFont:[UIFont boldSystemFontOfSize:10]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:PDColorDefaultPurple,
                                                        UITextAttributeFont:[UIFont boldSystemFontOfSize:10]}
                                             forState:UIControlStateSelected];
    
    self.delegate = self;
    self.HangoutVC = [[HangoutViewController alloc] init];
    self.HangoutNav = [[JMNavigationController alloc] initWithRootViewController:self.HangoutVC];
    
    self.FriendsVC = [[FriendsViewController alloc] init];
    self.friendsNav = [[JMNavigationController alloc] initWithRootViewController:self.FriendsVC];
    
    self.ProfilesVC = [[ProfileViewController alloc] init];
    self.profileNav = [[JMNavigationController alloc] initWithRootViewController:self.ProfilesVC];
    
    NSMutableArray *vcArray = [@[self.HangoutNav,self.friendsNav, self.profileNav] mutableCopy];
    self.viewControllers = vcArray;
    
    if (bIO7) {
      self.HangoutNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Hangout" //nil
                                                              image:[[UIImage imageNamed:@"icon_nav_me_n"]
                                                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                tag:0];
      self.friendsNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Friends" //nil
                                                                 image:[[UIImage imageNamed:@"icon_nav_new_n"]
                                                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                   tag:1];
      self.profileNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" //nil
                                                                image:[[UIImage imageNamed:@"icon_nav_reply_n"]
                                                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  tag:2];
      
      
      [self.HangoutNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"icon_nav_me_s"]
                                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
      [self.friendsNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"icon_nav_new_s"]
                                                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
      [self.profileNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"icon_nav_reply_s"]
                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
      
    }
    else{
      self.HangoutNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Hangout" //nil
                                                              image:[UIImage imageNamed:@"icon_nav_me_n"]
                                                                tag:0];
      self.friendsNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Friends" //nil
                                                                 image:[UIImage imageNamed:@"icon_nav_new_n"]
                                                                   tag:1];
      self.profileNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" //nil
                                                                image:[UIImage imageNamed:@"icon_nav_reply_n"]
                                                                  tag:2];
      
      [self.HangoutNav.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_nav_me_n"]
                            withFinishedUnselectedImage:[UIImage imageNamed:@"icon_nav_me_s"]];
      
      [self.friendsNav.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_nav_new_n"]
                               withFinishedUnselectedImage:[UIImage imageNamed:@"icon_nav_new_s"]];
      
      [self.profileNav.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_nav_reply_n"]
                              withFinishedUnselectedImage:[UIImage imageNamed:@"icon_nav_reply_s"]];
      
    }
    
}
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, isRunningOnIOS7?0.5:1)];
  line.backgroundColor = UIColorFromRGBC(0xd1);
  [self.tabBar addSubview:line];
  
  //__weak typeof(self) wSelf = self;
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark Custom Method


- (BOOL)tabBarHidden {
    return NO;
}

- (void)setTabBarHidden:(BOOL)tabBarHidden
{
  self.tabBar.hidden = tabBarHidden;
}

#pragma mark UITabBarController Delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
 return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}
@end
