//
//  DrawView.m
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "DrawView.h"
#import "DrawPath.h"

@interface DrawView()

//@property (assign, nonatomic) CGPoint location;
//@property (assign, nonatomic) CGPoint preLocation;
@property (assign, nonatomic) CGMutablePathRef drawPath;
@property (strong, nonatomic) NSMutableArray *drawPathArray;

@property (assign, nonatomic) BOOL pathReleased;

@end

@implementation DrawView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        self.lineWidth = 10.0;
        self.drawColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawView:context];
}

#pragma mark 绘制视图内容
- (void)drawView:(CGContextRef)context{
    for(DrawPath *path in self.drawPathArray){
        if(path.image == nil){
            CGContextAddPath(context, path.drawPath.CGPath);

            [path.drawColor set];
            CGContextSetLineWidth(context, path.lineWidth);
            CGContextSetLineCap(context, kCGLineCapRound);
            
            CGContextDrawPath(context, kCGPathStroke);  
        } else{
            //CGContextDrawImage(context, self.bounds, path.image.CGImage); //图片反向
            [path.image drawInRect:self.bounds];
        }
        
        
    }
    
    if (!self.pathReleased){
        CGContextAddPath(context, self.drawPath);
        
        [self.drawColor set];
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetLineCap(context, kCGLineCapRound);
        
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    
}


#pragma mark - 触摸事件
#pragma mark 触摸开始，创建绘图路径
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    self.pathReleased = NO;
    
    self.drawPath = CGPathCreateMutable();
    CGPathMoveToPoint(self.drawPath, NULL, location.x, location.y);
}

#pragma mark 移动过程中，将触摸点不断添加到绘图路径中
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
   
    CGPathAddLineToPoint(self.drawPath, NULL, location.x, location.y);
    
    [self setNeedsDisplay];
}

#pragma mark 触摸结束，释放路径
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.drawPathArray == nil){
        self.drawPathArray = [NSMutableArray array];
    }
    //UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.drawPath];
    DrawPath *path = [DrawPath drawPathWithCGPath:self.drawPath color:self.drawColor lineWidth:self.lineWidth];
    
    [self.drawPathArray addObject:path];
    
    CGPathRelease(self.drawPath);
    
    self.pathReleased = YES;
}

#pragma mark - 工具视图执行方法
- (void)undo{
    [self.drawPathArray removeLastObject];
    [self setNeedsDisplay];
}
- (void)clearScreen{
    [self.drawPathArray removeAllObjects];
    [self setNeedsDisplay];
}

#pragma mark - image setter
- (void)setImage:(UIImage *)image{
    DrawPath *path = [[DrawPath alloc]init];
    path.image = image;
    if(self.drawPathArray == nil){
        self.drawPathArray = [NSMutableArray array];
    }
    [self.drawPathArray addObject:path];
    
    [self setNeedsDisplay];
}
@end
