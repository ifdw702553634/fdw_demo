//
//  BezierView.m
//  PhotoSelectDemo
//
//  Created by mude on 2018/8/29.
//  Copyright © 2018年 DreamTouch. All rights reserved.
//

#import "BezierView.h"

@implementation BezierView

- (void)drawRect:(CGRect)rect {
    
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat r = self.frame.size.width;
    //三次曲线
    UIBezierPath* bPath = [UIBezierPath bezierPath];
    bPath.lineWidth = 5.0;
    bPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    bPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    //起始点
    [bPath moveToPoint:CGPointMake(x, y)];//y=225
    //添加两个控制点
    [bPath addCurveToPoint:CGPointMake(x-r/2, y+r/8) controlPoint1:CGPointMake(x-r/8, y-r/4) controlPoint2:CGPointMake(x-r/2, y-r/4)];
    [bPath addCurveToPoint:CGPointMake(x-r/4, y+r*5/8) controlPoint1:CGPointMake(x-r/2, y+r*3/8) controlPoint2:CGPointMake(x-r/4, y+r*5/8)];
    [bPath addLineToPoint:CGPointMake(x, y+r*7/8)];
    //另半边
    [bPath addLineToPoint:CGPointMake(x+r/4, y+r*5/8)];
    [bPath addCurveToPoint:CGPointMake(x+r/2, y+r/8) controlPoint1:CGPointMake(x+r/2, y+r*3/8) controlPoint2:CGPointMake(x+r/2, y+r/8)];
    [bPath addCurveToPoint:CGPointMake(x, y) controlPoint1:CGPointMake(x+r/2, y-r/4) controlPoint2:CGPointMake(x+r/8, y-r/4)];
    
    [bPath addLineToPoint:CGPointMake(x-r/8, y+r/4)];
    [bPath addLineToPoint:CGPointMake(x, y+r/2)];
    [bPath addLineToPoint:CGPointMake(x-r/8, y+r*3/4)];
    [bPath addLineToPoint:CGPointMake(x, y+r*7/8)];
    [bPath stroke];
}

@end
