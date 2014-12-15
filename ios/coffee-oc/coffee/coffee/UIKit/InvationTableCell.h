//
//  InvationTableCellTableViewCell.h
//  coffee
//
//  Created by wang xuan on 14-12-4.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@interface InvationTableCell : UITableViewCell

@property(nonatomic, strong) IBOutlet SwipeView *detailsView;
@property(nonatomic, strong) IBOutlet UIView *groupView;
@property(nonatomic, strong) IBOutlet UIButton *selectedButton;
@property(nonatomic, strong) IBOutlet UIView *countView;
@property(nonatomic, strong) IBOutlet UILabel *countLabel;
@property(nonatomic, strong) IBOutlet UILabel *groupName;

@property(nonatomic, strong) IBOutlet UIView *borderView;

@end
