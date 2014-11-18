//
//  ActivityReplyView.h
//  JoinMeDemo
//
//  Created by lixin on 14/11/15.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityReplyView : UIView
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)UILabel *time;

@property(nonatomic,strong)UIImageView *phoneImage;


- (void) setData:(NSString*)conntent time:(NSString*)time;
@end
