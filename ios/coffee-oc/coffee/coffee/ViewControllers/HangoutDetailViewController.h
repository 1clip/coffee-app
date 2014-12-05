//
//  HangoutDetailViewController.h
//  coffee
//
//  Created by wang xuan on 14-11-27.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "CFAvatarView.h"

@interface HangoutDetailViewController : UIViewController<SwipeViewDelegate, SwipeViewDataSource,UITableViewDataSource,UITableViewDelegate>
{    
}


@property (nonatomic, retain) IBOutlet CFAvatarView* activityImage;
@property (nonatomic, retain) IBOutlet UIView *detailView;
@property(nonatomic, retain) IBOutlet UIView *activityDetailView;
@property(nonatomic, retain) IBOutlet CFAvatarView *avatorImageView;
@property(nonatomic, retain) IBOutlet UIImageView *acceptActionButtonView;
@property(nonatomic, retain) IBOutlet UIImageView *cancelActionButtonView;
@property(nonatomic, retain) IBOutlet SwipeView* swipeView;
@property(nonatomic, retain) IBOutlet UITableView* activityStatusTableView;
@property(nonatomic, retain) IBOutlet UIView *activityActionView;
@property(nonatomic, retain) IBOutlet UILabel *locationLabel;
@property(nonatomic, retain) IBOutlet UIImageView *lbsView;
@property(nonatomic, retain) IBOutlet UIImageView *statusImageView;


@end
