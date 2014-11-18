//
//  HangoutView.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/15.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import "HangoutView.h"

@implementation HangoutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    [self initUI];
    return self;
}

- (void) setViewColor:(int)index{
    self.row = index;
    switch (index) {
        case 0:
            [self setBackgroundColor:[UIColor lightTextColor]];
            break;
        case 1:
            [self setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1.0]];
            break;
        case 2:
            [self setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:206.0/255.0 blue:180.0/255.0 alpha:1.0]];
            break;
        case 3:
            [self setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:188.0/255.0 blue:164.0/255.0 alpha:1.0]];
            break;
        case 4:
            [self setBackgroundColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
            break;
        case 5:
            [self setBackgroundColor:[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]];
            break;
        default:
            break;
    }
}

- (void) initUI{
    self.topic = [[UILabel alloc] init];
    self.topic.frame = CGRectMake(10, 10, 100, 30);
    self.topic.textColor = [UIColor whiteColor];
    self.topic.font = [UIFont systemFontOfSize:20];
    self.topic.text = @"Gaming";
    [self addSubview:self.topic];
    
    UIImage* img = [UIImage imageNamed:@"icon_chat_phiz_huang"];
    self.phoneImage = [[UIImageView alloc] initWithImage:img];
    int x = self.frame.size.width/2 - img.size.width/2;
    int y = self.frame.size.height/2 - img.size.height/2 -10;
    self.phoneImage.frame = CGRectMake(x, y, img.size.width, img.size.height);
    [self addSubview:self.phoneImage];
    
    self.name = [[UILabel alloc] init];
    self.name.frame = CGRectMake(self.phoneImage.frame.origin.x,
                                 self.phoneImage.frame.origin.y+img.size.height,
                                 100, 20);
    self.name.textColor = [UIColor whiteColor];
    self.name.font = [UIFont systemFontOfSize:12];
    self.name.text = @"阿屌丝";
    [self addSubview:self.name];
    
    UIImage* img1 = [UIImage imageNamed:@"pending"];
    self.pendingIcon = [[UIImageView alloc] initWithImage:img1];
    int x1 = self.frame.size.width/2 - img1.size.width/2;
    int y1 = self.frame.size.height-img1.size.height-16;
    self.pendingIcon.frame = CGRectMake(x1, y1, img1.size.width, img1.size.height);
    [self addSubview:self.pendingIcon];
    
    self.pendingCount = [[UILabel alloc] init];
    self.pendingCount.text = @"3";
    self.pendingCount.font = [UIFont systemFontOfSize:15];
    self.pendingCount.textColor = [UIColor whiteColor];
    self.pendingCount.frame = CGRectMake(self.pendingIcon.frame.origin.x + self.pendingIcon.frame.size.width + 2,
                                       self.pendingIcon.frame.origin.y, 20, 20);
    [self addSubview:self.pendingCount];
    
    UIImage* img2 = [UIImage imageNamed:@"icon_chat_phiz_jd"];
    self.cancelIcon = [[UIImageView alloc] initWithImage:img2];
    int x2 = self.pendingIcon.frame.origin.x - 40;
    int y2 = self.pendingIcon.frame.origin.y;
    self.cancelIcon.frame = CGRectMake(x2, y2, img2.size.width, img2.size.height);
    [self addSubview:self.cancelIcon];
    
    UIImage* img3 = [UIImage imageNamed:@"icon_chat_phiz_time"];
    self.bookIcon = [[UIImageView alloc] initWithImage:img3];
    int x3 = self.pendingIcon.frame.origin.x+self.pendingIcon.frame.size.width + 20;
    int y3 = self.pendingIcon.frame.origin.y;
    self.bookIcon.frame = CGRectMake(x3, y3, img3.size.width, img3.size.height);
    [self addSubview:self.bookIcon];
    
    
    self.bookCount = [[UILabel alloc] init];
    self.bookCount.text = @"3";
    self.bookCount.font = [UIFont systemFontOfSize:15];
    self.bookCount.frame = CGRectMake(self.bookIcon.frame.origin.x + self.bookIcon.frame.size.width + 2,
                                      self.bookIcon.frame.origin.y, 20, 20);
    self.bookCount.textColor = [UIColor whiteColor];
    [self addSubview:self.bookCount];
    
    self.clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clickButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.clickButton];
}


- (void) setData:(int)row{
    if (row == 0) {
        self.phoneImage.image = [UIImage imageNamed:@"icon_chat_plp_1"];
        self.bookIcon.hidden = YES;
        self.pendingIcon.hidden = YES;
        self.cancelIcon.hidden = YES;
        self.name.hidden = YES;
        self.topic.hidden = YES;
    }else {
        self.phoneImage.image = [UIImage imageNamed:@"icon_chat_phiz_huang"];
        self.bookIcon.hidden = NO;
        self.pendingIcon.hidden = NO;
        self.cancelIcon.hidden = NO;
        self.phoneImage.hidden = NO;
        self.name.hidden = NO;
        self.topic.hidden = NO;
    }
}

@end
