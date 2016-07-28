//
//  LoadingView.m
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:4];
        
        for (NSInteger i = 0; i < 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"images.bundle/loading%d.png",i];
            UIImage *image = [UIImage imageNamed:imageName];
            
            [arrayM addObject:image];
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:arrayM[0]];
        
        [imageView setCenter:self.center];
        [self addSubview:imageView];
        
        [imageView setAnimationImages:arrayM];
        [imageView setAnimationDuration:1.0f];
        [imageView startAnimating];
        
    }
    return self;
}

@end
