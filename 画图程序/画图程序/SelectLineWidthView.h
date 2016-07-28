//
//  SelectLineWidthView.h
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectLineWidthBlock)(CGFloat lineWidth);

@interface SelectLineWidthView : UIView

- (id)initWithFrame:(CGRect)frame afterSelectLineWidth:(SelectLineWidthBlock)afterSelectLineWidth;

@end
