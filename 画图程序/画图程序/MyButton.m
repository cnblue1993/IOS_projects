//
//  MyButton.m
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    if(self.selectedMyButton){
        CGRect frame = CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width, 2);
        [[UIColor redColor]set];
        UIRectFill(frame);
    }
    
}

- (void)setSelectedMyButton:(BOOL)selectedMyButton{
    _selectedMyButton = selectedMyButton;
    [self setNeedsDisplay];
}


@end
