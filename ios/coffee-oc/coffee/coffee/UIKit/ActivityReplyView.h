//
//  ActivityReplyView.h
//  coffee
//
//  Created by dihong on 14/11/26.
//  Copyright (c) 2014年 1clip. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CFAvatarView.h"

@interface ActivityReplyView : UIView
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)UILabel *time;

@property(nonatomic,strong)CFAvatarView *phoneImage;


- (void) setData:(NSString*)conntent time:(NSString*)time;
@end
