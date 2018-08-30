//
//  BezierViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 2018/6/12.
//  Copyright © 2018年 DreamTouch. All rights reserved.
//

#import "BezierViewController.h"

@interface BezierViewController ()<CAAnimationDelegate>{
    CAShapeLayer *_layerA;
    
    NSInteger _index;
    
    NSArray *_colorArr;
}

//弧度转角度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@property (nonatomic, strong) UIView *redView;

@end

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = CustomLocalizedString(@"bezierTitle", nil);
    
//    _redView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 10, 10)];
//    _redView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:_redView];
//    [self layerKeyFrameAnimation];
//    [self.view bringSubviewToFront:_redView];
    
//    UISlider *slider = [UISlider new];
//    slider.frame = CGRectMake(50, SCREEN_HEIGHT - 150,SCREEN_WIDTH-100, 50);
//    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:slider];
    
    _colorArr = @[[UIColor redColor],[UIColor grayColor],[UIColor greenColor],[UIColor blueColor],[UIColor yellowColor],[UIColor orangeColor]];
    
    
    //在cell上添加 bgView,给bgView添加两个手势检测方法
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapGesture.numberOfTapsRequired =1;
    singleTapGesture.numberOfTouchesRequired  =1;
    [self.view addGestureRecognizer:singleTapGesture];

    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired =2;
    doubleTapGesture.numberOfTouchesRequired =1;
    [self.view addGestureRecognizer:doubleTapGesture];
    //只有当doubleTapGesture识别失败的时候(即识别出这不是双击操作)，singleTapGesture才能开始识别
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
//    [self drawViewWithCoordinateX:100 CoordinateY:100 Radius:100 Color:_colorArr[arc4random() % 10]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) timerMethod{
    NSInteger random = arc4random() % 5;
    [self drawViewWithCoordinateX:SCREEN_WIDTH/2 CoordinateY:300 Radius:50 Color:[UIColor redColor]];
}

//两个手势分别响应的方法
-(void)handleSingleTap:(UIGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.view];
//    NSInteger random = arc4random() % 5;
//    [self drawViewWithCoordinateX:point.x CoordinateY:point.y Radius:50 Color:_colorArr[random]];
}

-(void)handleDoubleTap:(UIGestureRecognizer *)sender{
    NSLog(@"双击了1次");
    CGPoint point = [sender locationInView:self.view];
    NSInteger random = arc4random() % 5;
    [self drawViewWithCoordinateX:point.x CoordinateY:point.y Radius:50 Color:_colorArr[random]];
}


- (void)sliderValueChange:(UISlider *)slider
{
    _layerA.strokeStart = slider.value;
}

- (void)drawViewWithCoordinateX:(CGFloat)x CoordinateY:(CGFloat)y Radius:(CGFloat)r Color:(UIColor *)color{
    _index ++;
    [color set];
    //三次曲线
    UIBezierPath* bPath = [UIBezierPath bezierPath];
    bPath.lineWidth = 5.0;
    bPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    bPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    
    //起始点x=r/2 y=r/4
    [bPath moveToPoint:CGPointMake(r/2, r/4)];//y=225
    //添加两个控制点
    [bPath addCurveToPoint:CGPointMake(0, r*3/8) controlPoint1:CGPointMake(r*3/8, 0) controlPoint2:CGPointMake(0, 0)];
    [bPath addCurveToPoint:CGPointMake(r/4, r*7/8) controlPoint1:CGPointMake(0, r*5/8) controlPoint2:CGPointMake(r/4, r*7/8)];
    [bPath addLineToPoint:CGPointMake(r/2, r*9/8)];
    //另半边
    [bPath addLineToPoint:CGPointMake(r*3/4, r*7/8)];
    [bPath addCurveToPoint:CGPointMake(r, r*3/8) controlPoint1:CGPointMake(r, r*5/8) controlPoint2:CGPointMake(r, r*3/8)];
    [bPath addCurveToPoint:CGPointMake(r/2, r/4) controlPoint1:CGPointMake(r, 0) controlPoint2:CGPointMake(r*5/8, 0)];
    [bPath stroke];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x-r/2, y-r/2, r, 5*r/4)];
    view.backgroundColor = [UIColor clearColor];
    view.alpha = 0.8f;
    [self.view addSubview:view];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.lineWidth = 2.f;
    layer.strokeColor = color.CGColor;
    layer.fillColor = color.CGColor;
    layer.path = bPath.CGPath;
    [view.layer addSublayer:layer];
    
    
    //出现的动画
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    //每次动画的持续时间
//    animation.duration = 1;
//    //动画起始位置
//    animation.fromValue = @(0);
//    //动画结束位置
//    animation.toValue = @(1);
//    //动画重复次数
//    animation.repeatCount = 1;
//    [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    
    // 先缩小
    view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        view.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    
    UIBezierPath* vPath = [UIBezierPath bezierPath];
    vPath.lineWidth = 5.0;
    vPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    vPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    [vPath moveToPoint:CGPointMake(x, y)];
    //添加两个控制点
    [vPath addCurveToPoint:CGPointMake(x+100, y-200) controlPoint1:CGPointMake(x+100, y) controlPoint2:CGPointMake(x+100, y-200)];
    [vPath stroke];
    
//    UIBezierPath* vPath = [UIBezierPath bezierPath];
//    vPath.lineWidth = 5.0;
//    vPath.lineCapStyle = kCGLineCapRound;  //线条拐角
//    vPath.lineJoinStyle = kCGLineCapRound;  //终点处理
//    //起始点
//    [vPath moveToPoint:CGPointMake(x, y)]; //y=225 r= 200
//    [vPath addCurveToPoint:CGPointMake(x-r*2, y+r/2) controlPoint1:CGPointMake(x-r/2, y-r) controlPoint2:CGPointMake(x-r*2, y-r)];
//    [vPath addCurveToPoint:CGPointMake(x-r, y+r*5/2) controlPoint1:CGPointMake(x-r*2, y+r*3/2) controlPoint2:CGPointMake(x-r, y+r*5/2)];
//    [vPath addLineToPoint:CGPointMake(x, y+r*7/2)];
//    //另半边
//    [vPath addLineToPoint:CGPointMake(x+r, y+r*5/2)];
//    [vPath addCurveToPoint:CGPointMake(x+r*2, y+r/2) controlPoint1:CGPointMake(x+r*2, y+r*3/2) controlPoint2:CGPointMake(x+r*2, y+r/2)];
//    [vPath addCurveToPoint:CGPointMake(x, y) controlPoint1:CGPointMake(x+r*2, y-r) controlPoint2:CGPointMake(x+r/2, y-r)];
//    [vPath stroke];
    
    
//    view.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        CGRect frame = view.frame;
//        frame.origin.y -= 100;
//        frame.origin.x += 100;
//        view.frame = frame;
        
        //贝塞尔曲线画消失路线
        CAKeyframeAnimation *keyFA = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyFA.path = vPath.CGPath;
        keyFA.duration = 1.5f;
        keyFA.repeatCount = 1;
        keyFA.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        keyFA.fillMode = kCAFillModeForwards;
        keyFA.calculationMode = kCAAnimationPaced;
        keyFA.removedOnCompletion = NO;
        keyFA.delegate = self;
        [view.layer addAnimation:keyFA forKey:@""];
        
        view.alpha = 0;
//        view.transform = CGAffineTransformMakeScale(0.3, 0.3);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];


}

//关键帧动画
-(void)layerKeyFrameAnimation
{
    UIColor *color = [UIColor greenColor];
    [color set];
    //三次曲线
    UIBezierPath* bPath = [UIBezierPath bezierPath];
    bPath.lineWidth = 5.0;
    bPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    bPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    //起始点
    [bPath moveToPoint:CGPointMake(SCREEN_WIDTH/2, 225)];
    //添加两个控制点
//    [bPath addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH/2-100, 225) controlPoint:CGPointMake(SCREEN_WIDTH/2-50, 100)];
//    [bPath addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH/2, 400) controlPoint:CGPointMake(SCREEN_WIDTH/2-50, 200)];
    [bPath addCurveToPoint:CGPointMake(SCREEN_WIDTH/2-100, 250) controlPoint1:CGPointMake(SCREEN_WIDTH/2-25, 175) controlPoint2:CGPointMake(SCREEN_WIDTH/2-100, 175)];
    [bPath addCurveToPoint:CGPointMake(SCREEN_WIDTH/2-50, 350) controlPoint1:CGPointMake(SCREEN_WIDTH/2-100, 300) controlPoint2:CGPointMake(SCREEN_WIDTH/2-50, 350)];
    [bPath addLineToPoint:CGPointMake(SCREEN_WIDTH/2, 400)];
    //另半边
    [bPath addLineToPoint:CGPointMake(SCREEN_WIDTH/2+50, 350)];
    [bPath addCurveToPoint:CGPointMake(SCREEN_WIDTH/2+100, 250) controlPoint1:CGPointMake(SCREEN_WIDTH/2+100, 300) controlPoint2:CGPointMake(SCREEN_WIDTH/2+100, 250)];
    [bPath addCurveToPoint:CGPointMake(SCREEN_WIDTH/2, 225) controlPoint1:CGPointMake(SCREEN_WIDTH/2+100, 175) controlPoint2:CGPointMake(SCREEN_WIDTH/2+25, 175)];
    [bPath stroke];
    
    _layerA = [[CAShapeLayer alloc] init];
    _layerA.lineWidth = 5.f;
    _layerA.strokeColor = [UIColor redColor].CGColor;
    _layerA.fillColor = [UIColor clearColor].CGColor;
    _layerA.path = bPath.CGPath;
    [self.view.layer addSublayer:_layerA];
    //几个固定点
//    NSValue *orginalValue = [NSValue valueWithCGPoint:self.redView.layer.position];
//    NSValue *value_1 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
//    NSValue *value_2 = [NSValue valueWithCGPoint:CGPointMake(75, 200)];
//    NSValue *value_3 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
    
    //变动的属性,keyPath后面跟的属性是CALayer的属性
    CAKeyframeAnimation *keyFA = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //value数组，放所有位置信息，如果设置path，此项会被忽略
//    keyFA.values = @[orginalValue,value_1,value_2,value_3];
    //动画路径
    keyFA.path = bPath.CGPath;
    //该属性是一个数组，用以指定每个子路径(AB,BC,CD)的时间。如果你没有显式地对keyTimes进行设置，则系统会默认每条子路径的时间为：ti=duration/(帧数)，即每条子路径的duration相等
//    keyFA.keyTimes = @[@(0.025),@(0.025),@(0.025),@(0.025)];
    //动画总时间
    keyFA.duration = 5.0f;
    //重复次数，小于0无限重复
    keyFA.repeatCount = 1314;
    
    /*
     这个属性用以指定时间函数，类似于运动的加速度
     kCAMediaTimingFunctionLinear//线性
     kCAMediaTimingFunctionEaseIn//淡入
     kCAMediaTimingFunctionEaseOut//淡出
     kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
     kCAMediaTimingFunctionDefault//默认
     */
    keyFA.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    /*
     fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用.
     
     下面来讲各个fillMode的意义
     kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
     kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
     kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
     kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
     //添加动画
     */
    keyFA.fillMode = kCAFillModeForwards;
    
    /*
     在关键帧动画中还有一个非常重要的参数,那便是calculationMode,计算模式.该属性决定了物体在每个子路径下是跳着走还是匀速走，跟timeFunctions属性有点类似
     其主要针对的是每一帧的内容为一个座标点的情况,也就是对anchorPoint 和 position 进行的动画.当在平面座标系中有多个离散的点的时候,可以是离散的,也可以直线相连后进行插值计算,也可以使用圆滑的曲线将他们相连后进行插值计算. calculationMode目前提供如下几种模式
     
     kCAAnimationLinear calculationMode的默认值,表示当关键帧为座标点的时候,关键帧之间直接直线相连进行插值计算;
     kCAAnimationDiscrete 离散的,就是不进行插值计算,所有关键帧直接逐个进行显示;
     kCAAnimationPaced 使得动画均匀进行,而不是按keyTimes设置的或者按关键帧平分时间,此时keyTimes和timingFunctions无效;
     kCAAnimationCubic 对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算,对于曲线的形状还可以通过tensionValues,continuityValues,biasValues来进行调整自定义,这里的数学原理是Kochanek–Bartels spline,这里的主要目的是使得运行的轨迹变得圆滑;
     kCAAnimationCubicPaced 看这个名字就知道和kCAAnimationCubic有一定联系,其实就是在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统时间内运动的距离相同,此时keyTimes以及timingFunctions也是无效的.
     */
    keyFA.calculationMode = kCAAnimationPaced;
    
    //旋转的模式,auto就是沿着切线方向动，autoReverse就是转180度沿着切线动
    keyFA.rotationMode = kCAAnimationRotateAuto;
    
    //结束后是否移除动画
    keyFA.removedOnCompletion = NO;
    
    keyFA.delegate = self;
    
    //添加动画
    [self.redView.layer addAnimation:keyFA forKey:@""];
}

#pragma mark -动画代理方法
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%@", anim);
    NSLog(@"%d", flag);
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"%@", anim);
}

@end
