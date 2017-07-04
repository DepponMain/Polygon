//
//  ComatEffectivenessLine.m
//  HJComatEffectivenessShow
//
//  Created by 马海江 on 2017/6/24.
//  Copyright © 2017年 haiJiang. All rights reserved.
//

#import "ComatEffectivenessLine.h"

@interface ComatEffectivenessLine ()

@property (nonatomic, assign) int count;

@end

@implementation ComatEffectivenessLine

- (void)drawRect:(CGRect)rect{
    if (!_Values) {
        return;
    }
    
    if (_count == 3) {
        
        float longest = self.bounds.size.width / 2;// 最长的长度（即传入10的时候的长度）
        
        CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);// View中心点
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGPoint firstPoint;// 第一个顶点
        
        for (int i = 0; i < _count; i++) {
            
            float x, y;
            
            float fenMu = (float)i / _count;
            
            float xx = fabs(longest / 10 * [_Values[i] floatValue] * sin(2 * M_PI * fenMu));
            float yy = fabs(longest / 10 * [_Values[i] floatValue] * cos(2 * M_PI * fenMu));
            
            if (i == 0) {
                x = center.x;
                y = center.y - yy;
                
                firstPoint = CGPointMake(x, y);
                
                CGContextMoveToPoint(context, x, y);
            }else if (i == 1){
                x = center.x + xx;
                y = center.y + yy;
                
                CGContextAddLineToPoint(context, x, y);
            }else{
                x = center.x - xx;
                y = center.y + yy;
                
                CGContextAddLineToPoint(context, x, y);
                CGContextAddLineToPoint(context, firstPoint.x, firstPoint.y);
                
                [self showTheFiveScoreWithContext:context];
            }
//                NSLog(@"x == %f   y == %f",x, y);
        }
        return;
    }
    
    float longest = self.bounds.size.width / 2;// 最长的长度（即传入10的时候的长度）
    
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);// View中心点
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint firstPoint;// 第一个顶点
    
    NSInteger oneFour = _count / 4;// 一或四象限有几个顶点
    NSInteger oneTwo = _count / 2 + 1;// 一二象限有几个顶点
    
    for (int i = 0; i < _count; i++) {
        
        CGPoint point;
        
        float x, y;
        
        float fenMu = (float)i / _count;
        
        float xx = fabs(longest / 10 * [_Values[i] floatValue] * sin(2 * M_PI * fenMu));
        float yy = fabs(longest / 10  * [_Values[i] floatValue] * cos(2 * M_PI * fenMu));
        
        if (i < oneTwo) {
            x = center.x + xx;
        }else{
            x = center.x - xx;
        }
        if (i <= oneFour || i >= _count - oneFour || i == 1) {
            y = center.y - yy;
        }else {
            y = center.y + yy;
        }
        
        point = CGPointMake(x, y);
        
        if (i == 0) {
            firstPoint = point;
            CGContextMoveToPoint(context, point.x, point.y);
        }else if (i == _count - 1){
            CGContextAddLineToPoint(context, point.x, point.y);
            CGContextAddLineToPoint(context, firstPoint.x, firstPoint.y);
            [self showTheFiveScoreWithContext:context];
        }else{
            CGContextAddLineToPoint(context, point.x, point.y);
        }
//        NSLog(@"x == %f   y == %f",point.x, point.y);
    }
}
- (void)showTheFiveScoreWithContext:(CGContextRef)ctx{
#pragma mark -- 调边线宽度
    CGContextSetLineWidth(ctx, 2);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
#pragma mark -- 调边线颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextStrokePath(ctx);
}
- (void)setValues:(NSArray *)Values{
    _Values = Values;
    self.count = (int)Values.count;
    [self setNeedsDisplay];
}

@end
