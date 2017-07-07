# ComatEffectivenessView
任意多边形 类似战力分布图表

## 需求
在一个教育类APP中遇到这样一个功能：学生在学习的时候可以实时的观看自己每一章节的学习进度。因为课程分的章节数目不同（一种课程可能会有3—N个章节），所以就要求根据章节数来做多边形。
##与众不同之处
在网上查了一些Demo，基本上都是固定的五边形或者六边形，并不能根据章节数的不同自动切换。所以就决定自己来写了！
## 使用方法
抽出来的这个Demo总共有14个输入框，上面7个用来放（0-10.0）的数值，下面7个用来放对应的标签，点击下方按钮，即可
## 效果展示

![](https://github.com/DepponMain/ComatEffectivenessView/raw/master/GIF/Comat.gif)

## 思路
任意多边形的关键在于对于顶点所在象限的判断，判断出所在象限，再以中心点坐标为基准，X、Y坐标分别加或者减绝对值即可得出顶点坐标；
## 重点代码
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
        
        
##### *可下载Demo查看完整代码，如有纰漏，欢迎指正*
## 联系方式
* QQ：2779713120
* 邮箱：mahaijiang0117@126.com


<div class="footer">
	&copy; 2017/7/4 HJ.M
</div>
