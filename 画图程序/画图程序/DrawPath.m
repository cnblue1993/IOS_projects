//
//  DrawPath.m
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "DrawPath.h"

@implementation DrawPath

+ (id)drawPathWithCGPath:(CGPathRef)drawPath color:(UIColor *)color lineWidth:(CGFloat)lineWidth{
    DrawPath *path = [[DrawPath alloc]init];
    
    path.drawPath = [UIBezierPath bezierPathWithCGPath:drawPath];
    path.drawColor = color;
    path.lineWidth = lineWidth;
    
    return path;
}
@end
