//
//  ViewController.m
//  HJComatEffectivenessShow
//
//  Created by 马海江 on 2017/6/23.
//  Copyright © 2017年 haiJiang. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ViewWidth 120
#define ViewY 220

#import "ViewController.h"
#import "ComatEffectivenessView.h"
#import "ComatEffectivenessLine.h"

@interface ViewController ()

// 1-7 为（0-10.0）数字
@property (weak, nonatomic) IBOutlet UITextField *Value1;
@property (weak, nonatomic) IBOutlet UITextField *Value2;
@property (weak, nonatomic) IBOutlet UITextField *Value3;
@property (weak, nonatomic) IBOutlet UITextField *Value4;
@property (weak, nonatomic) IBOutlet UITextField *Value5;
@property (weak, nonatomic) IBOutlet UITextField *Value6;
@property (weak, nonatomic) IBOutlet UITextField *Value7;

// 8-14 为对应标签
@property (weak, nonatomic) IBOutlet UITextField *Value8;
@property (weak, nonatomic) IBOutlet UITextField *Value9;
@property (weak, nonatomic) IBOutlet UITextField *Value10;
@property (weak, nonatomic) IBOutlet UITextField *Value11;
@property (weak, nonatomic) IBOutlet UITextField *Value12;
@property (weak, nonatomic) IBOutlet UITextField *Value13;
@property (weak, nonatomic) IBOutlet UITextField *Value14;

@property (nonatomic, weak) ComatEffectivenessView *ComatView;
@property (nonatomic, weak) ComatEffectivenessLine *ComatLine;

@property (nonatomic, strong) NSMutableArray *showValues;// (0-10.0)的数字
@property (nonatomic, strong) NSMutableArray *showNames;// 顶点对应的标签

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.showValues = [NSMutableArray array];
    self.showNames = [NSMutableArray array];
#pragma mark -- 背景图片
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - ViewWidth)/2, ViewY, ViewWidth, ViewWidth)];
    back.image = [UIImage imageNamed:@"test_score"];
    [self.view addSubview:back];
#pragma mark -- 包裹区域
    ComatEffectivenessView *view = [[ComatEffectivenessView alloc] initWithFrame:CGRectMake((ScreenWidth - ViewWidth)/2, ViewY, ViewWidth, ViewWidth)];
    self.ComatView = view;
    view.alpha = 0.4;
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
#pragma mark -- 边线
    ComatEffectivenessLine *line = [[ComatEffectivenessLine alloc] initWithFrame:CGRectMake((ScreenWidth - ViewWidth)/2, ViewY, ViewWidth, ViewWidth)];
    self.ComatLine = line;
    line.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line];
}
#pragma mark -- 动画展示分布图
- (IBAction)Show:(id)sender {
    NSArray *Values = @[_Value1.text, _Value2.text, _Value3.text, _Value4.text, _Value5.text, _Value6.text, _Value7.text,
                        
                        _Value8.text, _Value9.text, _Value10.text, _Value11.text, _Value12.text, _Value13.text, _Value14.text];
    
    for (int i = 0; i < 7; i++) {
        CGFloat value = [self checkValue:Values[i]];
        if (value != -1) {
            NSNumber *number = [NSNumber numberWithFloat:value];
            [self.showValues addObject:number];
        }
    }
    for (int i = 7; i < Values.count; i++) {
        if ([Values[i] length] > 0) {
            [self.showNames addObject:Values[i]];
        }
    }
    
    if (!(self.showValues.count < 3)) {
//        NSLog(@"%@", showValues);
        
        self.ComatView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.ComatLine.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        self.ComatLine.Values = _showValues.copy;
        self.ComatView.Names = _showNames.copy;
        self.ComatView.Values = _showValues.copy;
        
        [UIView animateWithDuration:1.0 animations:^{
            self.ComatView.transform = CGAffineTransformIdentity;
            self.ComatLine.transform = CGAffineTransformIdentity;
        }];
        
        [self.showValues removeAllObjects];
        [self.showNames removeAllObjects];
    }
}
#pragma mark -- 筛选textField
- (CGFloat)checkValue:(NSString *)value{
    if ([value length] == 0) {
        return -1;
    }
    CGFloat v = [value floatValue];
    if (v >= 0 && v <= 10) {
        return v;
    }else{
        return -1;
    }
}

@end
