//
//  HangoutView.h
//  JoinMeDemo
//
//  Created by lixin on 14/11/15.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HangoutViewTouchDelegate;

@interface HangoutView : UIView
@property(nonatomic,assign)int row;//第几行
@property(nonatomic,assign)int column;//第几列

@property(nonatomic,strong)UILabel *topic;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *pendingCount;
@property(nonatomic,strong)UILabel *cancelCount;
@property(nonatomic,strong)UILabel *bookCount;

@property(nonatomic,strong)UIImageView *phoneImage;
@property(nonatomic,strong)UIImageView *pendingIcon;
@property(nonatomic,strong)UIImageView *cancelIcon;
@property(nonatomic,strong)UIImageView *bookIcon;

@property(nonatomic,strong)UIButton *clickButton;

@property (nonatomic,weak)id<HangoutViewTouchDelegate> delegate;

- (void) setViewColor:(int)index;
- (void) setData:(int)row;
@end

@protocol HangoutViewTouchDelegate
- (void) HangoutViewTouchHandle:(int)row;
@end
