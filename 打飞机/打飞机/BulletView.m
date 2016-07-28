//
//  BulletView.m
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "BulletView.h"

@implementation BulletView

- (id)initWithImage:(UIImage *)image bullet:(Bullet *)bullet{
    self = [super initWithImage:image];
    
    if (self){
        self.bullet = bullet;
    }
    return self;
}

@end
