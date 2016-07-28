//
//  DrawView.h
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) UIColor *drawColor;
@property (strong, nonatomic) UIImage *image;

- (void)undo;
- (void)clearScreen;
@end
