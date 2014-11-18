//
//  ActivityReplyView.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/15.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import "ActivityReplyView.h"

@implementation ActivityReplyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    [self initUI];
    return self;
}

- (void) initUI{
    UIImage* img = [UIImage imageNamed:@"icon_chat_phiz_huang"];
    self.phoneImage = [[UIImageView alloc] initWithImage:img];
    int x = 10;
    int y = 5;
    self.phoneImage.frame = CGRectMake(x, y, img.size.width, img.size.height);
    [self addSubview:self.phoneImage];
    
    self.content = [[UILabel alloc] init];
    self.content.frame = CGRectMake(self.phoneImage.frame.origin.x+self.phoneImage.frame.size.width + 10,
                                 self.phoneImage.frame.origin.y+5,
                                 300, 20);
    self.content.textColor = [UIColor blackColor];
    self.content.font = [UIFont systemFontOfSize:14];
    self.content.text = @"阿屌丝:我要大号，要晚点";
    [self addSubview:self.content];
    
    self.time = [[UILabel alloc] init];
    self.time.frame = CGRectMake(self.frame.size.width - 70,
                                    self.phoneImage.frame.origin.y+5,
                                    100, 20);
    self.time.textColor = [UIColor lightGrayColor];
    self.time.font = [UIFont systemFontOfSize:12];
    self.time.text = @"30min ago";
    [self addSubview:self.time];
}

- (void) setData:(NSString*)conntent time:(NSString*)time{
    
}

@end
