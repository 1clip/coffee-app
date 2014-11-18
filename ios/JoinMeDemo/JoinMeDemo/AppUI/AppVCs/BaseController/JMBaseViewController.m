//
//  JMBaseViewController.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/14.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import "JMBaseViewController.h"
#import "UINavigationController+ALExtension.h"

@interface JMBaseViewController (){
}

@end

@implementation JMBaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navigationItem.backBarButtonItem = nil;
  self.navigationItem.title = @" ";
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)onBackBarBtnClick
{
  [self.navigationController popViewControllerCustomAnimation];
}
@end
