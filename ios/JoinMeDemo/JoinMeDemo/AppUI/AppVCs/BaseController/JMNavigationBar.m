//
//  JMNavigationBar.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/13.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import "JMNavigationBar.h"
#import "AppDef.h"

@implementation JMNavigationBar

static CGFloat const kDefaultColorLayerOpacity = 0.f;
static CGFloat const kSpaceToCoverStatusBars = 20.0f;

- (void)setBarTintColor:(UIColor *)barTintColor {
  if (isRunningOnIOS7) {
    [super setBarTintColor:barTintColor];
    if (self.colorLayer == nil) {
      self.colorLayer = [CALayer layer];
      self.colorLayer.opacity = kDefaultColorLayerOpacity;
      [self.layer addSublayer:self.colorLayer];
    }
    self.colorLayer.backgroundColor = barTintColor.CGColor;
  }
  else{
    [super setTintColor:barTintColor];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (self.colorLayer != nil &&isRunningOnIOS7) {
    self.colorLayer.frame = CGRectMake(0, 0 - kSpaceToCoverStatusBars, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + kSpaceToCoverStatusBars);
    
    [self.layer insertSublayer:self.colorLayer atIndex:1];
  }
}


@end
