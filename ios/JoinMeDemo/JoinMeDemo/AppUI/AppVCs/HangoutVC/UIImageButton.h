//
//  UIImageButton.h
//  JoinMeDemo
//
//  Created by lixin on 14/11/15.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageButton : UIButton

@property(nonatomic,assign)int row;
@property(nonatomic,assign)int column;

- (void) setButtonImage:(int)index;
@end
