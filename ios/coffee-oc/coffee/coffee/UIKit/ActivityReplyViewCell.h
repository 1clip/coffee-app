//
//  ActivityReplyView.h
//  coffee
//
//  Created by dihong on 14/11/26.
//  Copyright (c) 2014年 1clip. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CFAvatarView.h"

@interface ActivityReplyViewCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *content;
@property(nonatomic,strong) IBOutlet UILabel *time;
@property(nonatomic,strong) IBOutlet CFAvatarView *phoneImage;

@end
