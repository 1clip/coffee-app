//
//  ActivityReplyView.h
//  coffee
//
//  Created by dihong on 14/11/26.
//  Copyright (c) 2014年 1clip. All rights reserved.
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

- (void) initUI{    CGFloat height = 30;
    self.phoneImage = [[CFAvatarView alloc] initWithFrame:CGRectMake(0, 3, height, height)];
    UIColor *bg = [UIColor whiteColor];
    [self.phoneImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"xiaowu"]];
    [self.phoneImage setBorderColor:bg];
    [self.phoneImage setBorderWidth:2.0];
    
    [self addSubview:self.phoneImage];
    
    self.content = [[UILabel alloc] init];
    self.content.frame = CGRectMake(self.phoneImage.frame.origin.x+self.phoneImage.frame.size.width + 10,
                                 self.phoneImage.frame.origin.y + 5,
                                 300, 20);
    self.content.textColor = [UIColor blackColor];
    self.content.font = [UIFont systemFontOfSize:12];
    self.content.text = @"阿屌丝:我要大号，要晚点";
    [self addSubview:self.content];
    
    self.time = [[UILabel alloc] init];
    self.time.frame = CGRectMake(self.frame.size.width - 70,
                                    self.phoneImage.frame.origin.y + 5,
                                    100, 20);
    self.time.textColor = [UIColor lightGrayColor];
    self.time.font = [UIFont systemFontOfSize:12];
    self.time.text = @"30min ago";
    [self addSubview:self.time];
}

- (void) setData:(NSString*)conntent time:(NSString*)time{
    
}

@end
