//
//  SelectLineWidthView.m
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "SelectLineWidthView.h"

#define kButtonCount 7
#define kButtonSpace 10.0

@interface SelectLineWidthView()
{
    SelectLineWidthBlock _selectLineWidthBlock;
}

@property (strong, nonatomic) NSArray *lineWidthArray;

@end

@implementation SelectLineWidthView

- (id)initWithFrame:(CGRect)frame afterSelectLineWidth:(SelectLineWidthBlock)afterSelectLineWidth{
    self = [super initWithFrame:frame];
    if (self) {
        _selectLineWidthBlock = afterSelectLineWidth;
        
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        NSArray *array = @[@(1.0),@(3.0),@(5.0),@(8.0),@(10.0),@(15.0),@(20.0)];
        self.lineWidthArray = array;
        
        [self createLineButtonWithArray:array];

    }
    return self;
}

#pragma mark 创建选择线宽的按钮
- (void)createLineButtonWithArray:(NSArray *)array{
    NSInteger count = array.count;
    CGFloat width = (self.bounds.size.width - (count + 1) * kButtonSpace) / count;
    CGFloat heith = self.bounds.size.height;
    
    NSInteger i = 0;
    for (i = 0 ; i < array.count ; i++){
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat startX = kButtonSpace + i * (kButtonSpace + width);
        
        [button setFrame:CGRectMake(startX, 5, width, heith - 10)];
        
        NSString *text = [NSString stringWithFormat:@"%@点",self.lineWidthArray[i]];
        [button setTitle:text forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setTag:i];
        
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }

}

#pragma mark - 按钮监听方法
- (void)tapButton:(UIButton *)button{
    _selectLineWidthBlock([self.lineWidthArray[button.tag]floatValue]);
}


@end
