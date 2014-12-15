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
@property(nonatomic, retain) IBOutlet SwipeView* swipeView;
@property(nonatomic, retain) IBOutlet UITableView* activityStatusTableView;
@property(nonatomic, retain) IBOutlet UIView *activityActionView;
@property(nonatomic, retain) IBOutlet UILabel *locationLabel;

@property(nonatomic, strong) IBOutlet CFAvatarView *postAvator;
@property(nonatomic, strong) IBOutlet UIView *postBackgroundView;
@property(nonatomic, strong) IBOutlet UITextField *postText;

@property(nonatomic, strong) IBOutlet UIButton *firstButton;
@property(nonatomic, strong) IBOutlet UIButton *secondButton;
@property(nonatomic, strong) IBOutlet UIButton *thirdButton;
@property(nonatomic, strong) IBOutlet UIView *actionBorder;
@property(nonatomic, strong) IBOutlet UILabel* countdownLabel;

@property(nonatomic, strong) IBOutlet UIButton *leftButton;
@property(nonatomic, strong) IBOutlet UIButton *rightButton;
@property(nonatomic, strong) IBOutlet UILabel* leftLabel;
@property(nonatomic, strong) IBOutlet UILabel* rightLabel;
@property(nonatomic, strong) IBOutlet UILabel* addressLabel;
@property(nonatomic, strong) IBOutlet UIButton* addressButton;


@end
