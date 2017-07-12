//
//  ComatEffectivenessView.m
//  HJComatEffectivenessShow
//
//  Created by 马海江 on 2017/6/23.
//  Copyright © 2017年 haiJiang. All rights reserved.
//

#define LabelScale 1.3 // Label与圆心的距离
#define ValuesMax 10 // 分数最大值（我写的0-10）

#import "ComatEffectivenessView.h"

@interface ComatEffectivenessView ()

@property (nonatomic, assign) int count;

@end

@implementation ComatEffectivenessView

- (void)drawRect:(CGRect)rect{
    if (!_Values) {
        return;
    }
    
    for (UILabel *label in self.subviews) {
        [label removeFromSuperview];
    }
    
    if (_count == 3) {
        
        float longest = self.bounds.size.width / 2;// 最长的长度（即传入10的时候的长度）
        
        CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);// View中心点
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGPoint firstPoint;// 第一个顶点
        
        for (int i = 0; i < _count; i++) {
            
            float x, y;
            
            float fenMu = (float)i / _count;
            
            float xx = fabs(longest / ValuesMax * [_Values[i] floatValue] * sin(2 * M_PI * fenMu));
            float yy = fabs(longest / ValuesMax * [_Values[i] floatValue] * cos(2 * M_PI * fenMu));
            
#pragma mark -- label的中心点(后面*的1.2，数值越大label离中心越远)
            float centerX = fabs(longest * sin(2 * M_PI * fenMu)) * LabelScale;
            float centerY = fabs(longest * cos(2 * M_PI * fenMu)) * LabelScale;
#pragma mark -- 这里修改label的属性
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:12];
            if (_Names.count <= i) {
                label.text = @"";
            }else{
                label.text = _Names[i];
            }
            [label sizeToFit];
            [self addSubview:label];
            
            if (i == 0) {
                x = center.x;
                y = center.y - yy;
                
                firstPoint = CGPointMake(x, y);
                
                CGContextMoveToPoint(context, x, y);
                
                label.center = CGPointMake(center.x, center.y - centerY);
            }else if (i == 1){
                x = center.x + xx;
                y = center.y + yy;
                
                CGContextAddLineToPoint(context, x, y);
                
                label.center = CGPointMake(center.x + centerX, center.y + centerY);
            }else{
                x = center.x - xx;
                y = center.y + yy;
                
                CGContextAddLineToPoint(context, x, y);
                CGContextAddLineToPoint(context, firstPoint.x, firstPoint.y);
                
                [self showTheFiveScoreWithContext:context];
                
                label.center = CGPointMake(center.x - centerX, center.y + centerY);
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
        
        float xx = fabs(longest / ValuesMax * [_Values[i] floatValue] * sin(2 * M_PI * fenMu));
        float yy = fabs(longest / ValuesMax * [_Values[i] floatValue] * cos(2 * M_PI * fenMu));
        
#pragma mark -- label的中心点(后面*的1.2，数值越大label离中心越远)
        float centerX = fabs(longest * sin(2 * M_PI * fenMu)) * LabelScale;
        float centerY = fabs(longest * cos(2 * M_PI * fenMu)) * LabelScale;
#pragma mark -- 这里修改label的属性
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12];
        if (_Names.count <= i) {
            label.text = @"";
        }else{
            label.text = _Names[i];
        }
        [label sizeToFit];
        [self addSubview:label];
        CGPoint labelCenter;
        
        if (i < oneTwo) {
            x = center.x + xx;
            labelCenter.x = center.x + centerX;
        }else{
            x = center.x - xx;
            labelCenter.x = center.x - centerX;
        }
        if (i <= oneFour || i >= _count - oneFour || i == 1) {
            y = center.y - yy;
            labelCenter.y = center.y - centerY;
        }else {
            y = center.y + yy;
            labelCenter.y = center.y + centerY;
        }
        
        point = CGPointMake(x, y);
        
        label.center = labelCenter;
        
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
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
#pragma mark -- 调区域内的颜色
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextFillPath(ctx);
}
- (void)setValues:(NSArray *)Values{
    _Values = Values;
    self.count = (int)Values.count;
    [self setNeedsDisplay];
}

@end
