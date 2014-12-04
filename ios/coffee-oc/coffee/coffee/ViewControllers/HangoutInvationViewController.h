//
//  HangoutInvationViewController.h
//  coffee
//
//  Created by wang xuan on 14-12-4.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvationTableCell.h"
#import "SwipeView.h"

@interface HangoutInvationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, SwipeViewDelegate, SwipeViewDataSource>


@property(nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property(nonatomic, strong) IBOutlet UITableView* tableView;


@end
