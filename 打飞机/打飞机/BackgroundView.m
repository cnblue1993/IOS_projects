//
//  BackgroundView.m
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "BackgroundView.h"

@interface BackgroundView()

@property (strong, nonatomic) UIImageView *bg1;
@property (strong, nonatomic) UIImageView *bg2;

@end
@implementation BackgroundView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIImageView *bg1 = [[UIImageView alloc]initWithImage:image];
        [self addSubview:bg1];
        self.bg1 = bg1;
        
        UIImageView *bg2 = [[UIImageView alloc]initWithImage:image];
        [self addSubview:bg2];
        self.bg2 = bg2;
    }
    
    return self;
}
#pragma mark 更新背景图片位置
- (void)changeBGWithFrame1:(CGRect)frame1 Frame2:(CGRect)frame2{
    [self.bg1 setFrame:frame1];
    [self.bg2 setFrame:frame2];
}
@end
