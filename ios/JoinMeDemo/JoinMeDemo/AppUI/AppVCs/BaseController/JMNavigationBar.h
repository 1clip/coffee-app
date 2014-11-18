//
//  JMNavigationBar.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/13.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMNavigationBar : UINavigationBar
@property (nonatomic, strong) CALayer *colorLayer;
- (void)setBarTintColor:(UIColor *)barTintColor;
@end
