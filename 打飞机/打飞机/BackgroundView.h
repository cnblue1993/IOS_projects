//
//  BackgroundView.h
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundView : UIView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;

#pragma mark 更新背景图片位置
- (void)changeBGWithFrame1:(CGRect)frame1 Frame2:(CGRect)frame2;

@end
