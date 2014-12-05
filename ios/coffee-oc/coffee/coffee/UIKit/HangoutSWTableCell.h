//
//  Hangout.h
//  coffee
//
//  Created by wang xuan on 14-12-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "SWTableViewCell.h"
#import "CFAvatarView.h"

@interface HangoutSWTableCell : SWTableViewCell


@property(nonatomic, strong) IBOutlet UIImageView * activityImage;
@property(nonatomic, strong) IBOutlet CFAvatarView *avatorImage;
@property(nonatomic, strong) IBOutlet UIView *borderView;

@property(nonatomic, strong) IBOutlet UILabel* userNameLabel;
@property(nonatomic, strong) IBOutlet UILabel* topicLabel1;
@property(nonatomic, strong) IBOutlet UILabel* topicLabel2;

@property(nonatomic, strong) IBOutlet UILabel* schedule;


@end
