//
//  HeroView.m
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "HeroView.h"

@implementation HeroView

- (id)initWithImages:(NSArray *)images{
    self = [super initWithImage:images[0]];
    
    if (self) {
        [self setAnimationImages:images];
        [self setAnimationDuration:1.0f];
        [self startAnimating];
    }
    
    return self;
}
@end
