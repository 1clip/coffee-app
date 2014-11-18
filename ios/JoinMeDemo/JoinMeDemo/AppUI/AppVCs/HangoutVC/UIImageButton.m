//
//  UIImageButton.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/15.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import "UIImageButton.h"

@implementation UIImageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setButtonImage:(int)index{
    [self setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:188.0/255.0 blue:164.0/255.0 alpha:1.0]];
    switch (index) {
        case 0:
            [self setImage:[UIImage imageNamed:@"dinner-22"] forState:UIControlStateNormal];
            break;
        case 1:
            [self setImage:[UIImage imageNamed:@"coffee-22"] forState:UIControlStateNormal];
            break;
        case 2:
            [self setImage:[UIImage imageNamed:@"shopping-22"] forState:UIControlStateNormal];
            break;
        case 3:
            [self setImage:[UIImage imageNamed:@"movie-22"] forState:UIControlStateNormal];
            break;
        case 4:
            [self setImage:[UIImage imageNamed:@"KTV-22"] forState:UIControlStateNormal];
            break;
        case 5:
            [self setImage:[UIImage imageNamed:@"shower-22"] forState:UIControlStateNormal];
            break;
        case 6:
            [self setImage:[UIImage imageNamed:@"shower-22"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
@end
