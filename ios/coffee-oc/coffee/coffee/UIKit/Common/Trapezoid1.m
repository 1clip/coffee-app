//
//  Trapezoid1.m
//  coffee
//
//  Created by wang xuan on 14-12-9.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Trapezoid1.h"
#import "ViewEnums.h"

@implementation Trapezoid1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect frameSize =self.bounds;
    
    
    CGContextSaveGState(context);
    
    
    CGContextMoveToPoint(context, 0, 0);//起始点
    
    
    CGContextAddLineToPoint (context, frameSize.size.width, frameSize.size.height * 0.06);//上线
    
    
    CGContextAddLineToPoint (context, frameSize.size.width, 0);
    
    
    CGContextClosePath(context);//收拢， 做成直角梯形
    
    CGContextMoveToPoint(context, 0, frameSize.size.height);//起始点
    
    
    CGContextAddLineToPoint (context, frameSize.size.width, frameSize.size.height * 0.94);//上线
    
    
    CGContextAddLineToPoint (context, frameSize.size.width, frameSize.size.height);
    
    
    CGContextClosePath(context);//收拢， 做成直角梯形
    
    
    [[CoffeeUIColor GrayBackgroundColor] setFill];
    
    
    CGContextDrawPath(context, kCGPathFill);
    
    
    CGContextRestoreGState(context);

}

@end
