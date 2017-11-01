//
//  YMView.m
//  ObjCALayer
//
//  Created by mt y on 2017/10/30.
//  Copyright © 2017年 mt y. All rights reserved.
//

#import "YMView.h"

@implementation YMView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    NSLog(@"3");
    NSLog(@"%s",__func__);
    //只有在drawRect方法中能够得到上下文信息
    CGContextRef context =  UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, 100, 100));
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextFillPath(context);
    
}

// 每一个view都带有一个layer,这个layer的delegate就是这个view,当这个view要显示的时候,就是layer要显示,系统会调用needDisplay,drawLayer方法会调用,父类的drawLayer会调用view的drawRect并且将上下文信息传递过去
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"1");
    [super drawLayer:layer inContext:ctx];
    NSLog(@"2");
}
@end
