//
//  ViewController.m
//  ObjCALayer
//
//  Created by mt y on 2017/10/30.
//  Copyright © 2017年 mt y. All rights reserved.
//

#import "ViewController.h"

#import "YMView.h"

@interface ViewController ()<CALayerDelegate>


@property(nonatomic, assign)CGFloat voicePower;//音量参数

@property (nonatomic, strong)UIView *myContentView;//内容view

@property (nonatomic, strong)CAShapeLayer *contentLayer;//内容Layer

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layerTwo];
    
    [self layerThree];
    
    [self initShapeLayer];
    
    [self initVoice];
    
    [self initprogressBar];
}


#pragma mark -Layer
// 对于view的非根layer,当改变某些属性的时候,系统会存在隐式动画,系统文档中凡是带有Animatable都是自带隐式动画
// 对于view的根layer而言,不存在隐式动画
- (void)layerOne
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = self.view.center;
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.view.layer addSublayer:layer];
    
}
- (void)layerTwo
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = self.view.center;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.borderColor = [UIColor redColor].CGColor;
    layer.borderWidth = 2;
    layer.delegate = self;
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}
- (void)layerThree
{
    YMView *ymView = [YMView new];
    ymView.frame = CGRectMake(0, 0, 199, 100);
    ymView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:ymView];
}
#pragma mark -CAShapeLayer
//绘制多边形
- (void)initShapeLayer
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(200, 200, 100, 200);
    view.backgroundColor = [UIColor orangeColor];
    view.tag = 1000;
    [self.view addSubview:view];
    
    CGFloat width = CGRectGetWidth(view.frame);
    CGFloat heigh = CGRectGetHeight(view.frame);
    CGFloat rightSpace = 10;
    CGFloat topSpace = 15;

    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(width - rightSpace, 0);
    CGPoint point3 = CGPointMake(width - rightSpace, topSpace);
    CGPoint point4 = CGPointMake(width, topSpace);
    CGPoint point5 = CGPointMake(width - rightSpace, topSpace + 10);
    CGPoint point6 = CGPointMake(width - rightSpace, heigh);
    CGPoint point7 = CGPointMake(0, heigh);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    view.layer.mask = layer;
}
//绘制话筒
- (void)initVoice
{
    self.myContentView = [UIView new];
    _myContentView.frame = CGRectMake(0, 200, 100, 200);
 
    _myContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myContentView];
    //添加内容Layer
//    CALayer *contentLayer = [CALayer layer];
//    contentLayer.frame = CGRectMake(0, 0, 100, 200);
//    contentLayer.backgroundColor = [UIColor blueColor].CGColor;
////    [view.layer setNeedsDisplay];
////    [contentLayer setNeedsDisplay];
//    [view.layer addSublayer:contentLayer];
    UIBezierPath *contentPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(_myContentView.frame), CGRectGetHeight(_myContentView.frame)) cornerRadius:0];
    self.contentLayer = [CAShapeLayer layer];
    self.contentLayer.path = contentPath.CGPath;
    
    self.contentLayer.fillColor = [UIColor whiteColor].CGColor;
    self.contentLayer.borderColor =  [UIColor grayColor].CGColor;
    self.contentLayer.borderWidth = 2;
    [_myContentView.layer addSublayer:self.contentLayer];
    
    
    _myContentView.clipsToBounds = YES;
    //绘制边框
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 200) cornerRadius:50];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.backgroundColor = [UIColor redColor].CGColor;
    self.myContentView.layer.mask = layer;
    
}
//刷新话筒
- (void)refeshVoice:(UIView *)view andContentLayer:(CAShapeLayer *)contentLayer
{
    CGFloat height = CGRectGetHeight(view.frame)*_voicePower;
    [contentLayer removeFromSuperlayer];
    contentLayer = nil;
    UIBezierPath *myPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetHeight(view.frame) - height, CGRectGetWidth(view.frame), height) cornerRadius:0];
    contentLayer = [CAShapeLayer layer];
    contentLayer.path = myPath.CGPath;
    contentLayer.fillColor = [UIColor grayColor].CGColor;
    [view.layer addSublayer:contentLayer];
}
//绘制进度条
- (void)initprogressBar
{
    
    CAShapeLayer *shaprLayer = [CAShapeLayer layer];
    shaprLayer.frame = CGRectMake(100, 400, 100, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    shaprLayer.path = path.CGPath;
    shaprLayer.fillColor = [UIColor clearColor].CGColor;
    shaprLayer.lineWidth = 2;
    shaprLayer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:shaprLayer];
    //开启动画
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shaprLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];

}

#pragma mark -CALayerDelegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 100, 100));
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    CGContextFillPath(ctx);
}
#pragma mark -Touchs
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //改变话筒
    if ((_voicePower < 1 && _voicePower> 0) || _voicePower == 0) {
        _voicePower += 0.1;
    }else{
        _voicePower = 1;
    }
    [self refeshVoice:self.myContentView andContentLayer:self.contentLayer];
    
    
    //改变绘制多边性
    UIView *myView = [self.view viewWithTag:1000];
    myView.transform = CGAffineTransformScale(myView.transform, 0.5, 1.5);
    
    CALayer *layer = self.view.layer.sublayers[0];
    //方式一：可以直接设置layer.transform来设置平移缩放旋转
//    CATransform3D tran = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    //当动画执行一次后不再继续执行：原因是每一次操作都是相对于原始位置的，而原始位置是不变的，所以画面将不再有旋转，要想有旋转就必须
    CATransform3D transs = CATransform3DRotate(layer.transform, M_PI/4, 0, 0, 1);

//    CATransform3D trans = CATransform3DTranslate(tran, 50, 50, 0);
    layer.transform = transs;
    //方式二：通过kvc直接设置
//    [layer setValue:@M_PI forKeyPath:@"transform.rotation.z"];
    [CATransaction begin];

    [CATransaction setAnimationDuration:1];
    [CATransaction setCompletionBlock:^{
//        self.view.backgroundColor = [UIColor grayColor];
    }];
    
//    [CATransaction setDisableActions:YES];
//        layer.position = CGPointMake(arc4random_uniform(300), arc4random_uniform(300));
//        layer.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1].CGColor;
//        layer.bounds = CGRectMake(0, 0, arc4random_uniform(200), arc4random_uniform(200));
//        [CATransaction commit];
    
}
@end
