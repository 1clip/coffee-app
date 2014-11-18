//
//  JMNavigationController.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/13.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import "JMNavigationController.h"
#import "JMNavigationBar.h"
#import "AppDef.h"

@interface JMNavigationController ()

@end

@implementation JMNavigationController

- (id)init {
  self = [super initWithNavigationBarClass:[JMNavigationBar class] toolbarClass:nil];
  if(self) {
    // Custom initialization here, if needed.
  }
  return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
  self = [super initWithNavigationBarClass:[JMNavigationBar class] toolbarClass:nil];
  if(self) {
    self.viewControllers = @[rootViewController];
    if ([self.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
      [self.navigationBar setBarTintColor:PDColorBarBgColorDefault];
    }
    else{
      self.navigationBar.translucent = NO;
      [self.navigationBar setTintColor:PDColorBarBgColorDefault];
    }
  }
  
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
