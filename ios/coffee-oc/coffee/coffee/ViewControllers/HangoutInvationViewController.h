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

@interface HangoutInvationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, SwipeViewDataSource, SwipeViewDelegate>


@property(nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property(nonatomic, strong) IBOutlet UITableView* tableView;

@property(nonatomic, strong) IBOutlet UIButton *closeButton;
@property(nonatomic, strong) IBOutlet UIButton *okButton;



@end
