//
//  HangoutViewControllerV2.h
//  coffee
//
//  Created by wang xuan on 14-12-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HangoutSWTableCell.h"
#import "SWTableViewCell.h"
#import "CFAvatarView.h"

@interface HangoutViewControllerV2 : UIViewController<UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>

@property(nonatomic, strong) IBOutlet UITableView * hangoutView;
@property(nonatomic, strong) IBOutlet CFAvatarView* personalAvator;
@property(nonatomic, strong) IBOutlet UILabel* userName;
@property(nonatomic, strong) IBOutlet UIView *bottomView;
@end
