//
//  SelectColorView.h
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectColorBlock)(UIColor *color);

@interface SelectColorView : UIView

- (id)initWithFrame:(CGRect)frame afterSelectColor:(SelectColorBlock)afterSelectColor;


@end
