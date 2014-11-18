//
//  HangoutViewController.h
//  JoinMeDemo
//
//  Created by lixin on 14/11/14.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMBaseViewController.h"
#import "HangoutView.h"

@interface HangoutViewController : JMBaseViewController<UITableViewDataSource,UITableViewDelegate,HangoutViewTouchDelegate>

@end
