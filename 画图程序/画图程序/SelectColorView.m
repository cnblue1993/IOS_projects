//
//  SelectColorView.m
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "SelectColorView.h"

#define kButtonCount 9
#define kButtonSpace 10.0

@interface SelectColorView()
{
    SelectColorBlock _selectColorBlock;
}

@property (strong, nonatomic) NSArray *colorArray;

@end

@implementation SelectColorView

- (id)initWithFrame:(CGRect)frame afterSelectColor:(SelectColorBlock)afterSelectColor{
    self = [super initWithFrame:frame];
    if(self){
        _selectColorBlock = afterSelectColor;
        [self setBackgroundColor:[UIColor lightGrayColor]];
        NSArray *array = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor],[UIColor darkGrayColor],[UIColor brownColor],[UIColor blackColor]];
        self.colorArray = array;
        
        [self createColorButtonsWithArray:array];
    }
    return self;
}

#pragma mark - 绘制颜色按钮
- (void)createColorButtonsWithArray:(NSArray *)array{
    NSInteger count = array.count;
    CGFloat width = (self.bounds.size.width - (count + 1) * kButtonSpace) / count;
    CGFloat heith = self.bounds.size.height;
    
    NSInteger i = 0;
    for (i = 0 ; i < array.count ; i++){
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat startX = kButtonSpace + i * (kButtonSpace + width);
        
        [button setFrame:CGRectMake(startX, 5, width, heith - 10)];
        [button setBackgroundColor:array[i]];
        [button setTag:i];
        
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }

}

#pragma mark - 按钮监听方法
- (void)tapButton:(UIButton *)button{
    _selectColorBlock(self.colorArray[button.tag]);
     NSLog(@"select");
}

@end
