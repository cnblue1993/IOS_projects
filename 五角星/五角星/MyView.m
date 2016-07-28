//
//  MyView.m
//  五角星
//
//  Created by anne on 16/4/25.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "MyView.h"

CGPoint points[5];

@interface MyView()
{
    BOOL _hasPoints;
}
@end

@implementation MyView

- (void)loadPoints{
    CGFloat r = 100.0;
    points[0] = CGPointMake(0, - r);
    CGFloat angle = 4.0 * M_PI / 5.0;
    
    for(int i = 1; i < 5; i++){
        CGFloat x = cosf(i * angle - M_PI_2) * r;
        CGFloat y = sinf(i *angle - M_PI_2) * r;
        
        points[i] = CGPointMake(x, y);
    }

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if(!_hasPoints){
        [self loadPoints];
        _hasPoints = true;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawRandomStarWithContext:context count:10];
    
//    for(int i = 0; i < 10; i++){
//        CGPoint center = CGPointMake(arc4random_uniform(320), arc4random_uniform(568));
//        CGFloat r = arc4random() % 50 + 50.0;
//        
//        [self drawStar2:context center:center r:r];
//    }
//    CGContextSaveGState(context);
//    
//    CGContextScaleCTM(context, 0.5, 0.5);
//    
//    [self drawStar:context];
//    
//    CGContextRestoreGState(context);
//    
//    [self drawStar2:context center:CGPointMake(100.0, 50.0) r:40];
    
    
}

#pragma mark - 绘制方法
#pragma mark 生成随机颜色
- (UIColor *)randomColor{
    CGFloat r = arc4random_uniform(255) / 255.0;
    CGFloat g = arc4random_uniform(255) / 255.0;
    CGFloat b = arc4random_uniform(255) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}
#pragma mark 随机绘制N个五角星
- (void)drawRandomStarWithContext:(CGContextRef)context count:(NSInteger)n{
    for(NSInteger i = 0; i < n; i++){
        CGContextSaveGState(context);
        
        CGFloat x = arc4random() % 320;
        CGFloat y = arc4random() % 568;
        CGContextTranslateCTM(context, x, y);
        
        CGFloat angle = (arc4random() % 180) * M_PI / 180.0;
        CGContextRotateCTM(context, angle);
        
        CGFloat scale = arc4random_uniform(5) / 10.0 + 0.5;
        CGContextScaleCTM(context, scale, scale);
        
        [self drawStar3:context];
        
        CGContextRestoreGState(context);
    }
    
}

#pragma mark 绘制五角星
- (void)drawStar3:(CGContextRef)context{
    
    [[self randomColor]set];
    
    CGContextMoveToPoint(context, points[0].x, points[0].y);
    
    for(int i = 1; i < 5; i++){
        
        CGContextAddLineToPoint(context, points[i].x, points[i].y);
    }
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    //[[UIColor redColor]set];
    //CGContextDrawPath(context, kCGPathEOFillStroke);
}

#pragma mark 绘制五角星
- (void)drawStar:(CGContextRef)context{
    
    CGPoint center =  CGPointMake(160.0, 270.0);
    CGFloat r = 100.0;
    CGPoint point1 = CGPointMake(center.x, center.y - r);
    CGFloat angle = 4.0 * M_PI / 5.0;
    CGContextMoveToPoint(context, point1.x, point1.y);
    
    for(int i = 1; i < 5; i++){
        CGFloat x = cosf(i * angle - M_PI_2) * r;
        CGFloat y = sinf(i *angle - M_PI_2) * r;
        
        CGContextAddLineToPoint(context, x + center.x, y + center.y);
    }
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    //[[UIColor redColor]set];
    //CGContextDrawPath(context, kCGPathEOFillStroke);
}
#pragma mark 绘制五角星
- (void)drawStar2:(CGContextRef)context center:(CGPoint)center r:(CGFloat)r{
    
    CGPoint point1 = CGPointMake(center.x, center.y - r);
    CGFloat angle = 4.0 * M_PI / 5.0;
    CGContextMoveToPoint(context, point1.x, point1.y);
    
    for(int i = 1; i < 5; i++){
        CGFloat x = cosf(i * angle - M_PI_2) * r;
        CGFloat y = sinf(i *angle - M_PI_2) * r;
        
        CGContextAddLineToPoint(context, x + center.x, y + center.y);
    }
    CGContextClosePath(context);
    
    [[self randomColor]set];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    //[[UIColor redColor]set];
    //CGContextDrawPath(context, kCGPathEOFillStroke);
}

@end
