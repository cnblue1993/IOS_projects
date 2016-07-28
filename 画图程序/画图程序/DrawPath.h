//
//  DrawPath.h
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawPath : NSObject

@property (strong, nonatomic) UIBezierPath *drawPath;
@property (strong, nonatomic) UIColor *drawColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) UIImage *image;

+ (id)drawPathWithCGPath:(CGPathRef)drawPath
                   color:(UIColor *)color
               lineWidth:(CGFloat)lineWidth;

@end
