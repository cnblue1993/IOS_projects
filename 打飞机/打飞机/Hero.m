//
//  Hero.m
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "Hero.h"
#import "Bullet.h"

#define kFireCount 3

@implementation Hero

+ (id)heroWithSize:(CGSize)size gameArea:(CGRect)gameArea{
    Hero *h = [[Hero alloc]init];
    
    CGFloat x = gameArea.size.width / 2;
    CGFloat y = gameArea.size.height - size.height;
    
    h.position = CGPointMake(x, y);
    h.bombCount = 0;
    h.isEnhancedBullet = YES;
    h.enhancedTime = 0;
    
    h.bulletSet = [NSMutableSet set];
    
    return h;
}

- (CGRect)collisionFrame{
    CGFloat x = self.position.x - self.size.width / 4.0;
    CGFloat y = self.position.y - self.size.height / 2.0;
    CGFloat w = self.size.width / 2.0;
    CGFloat h = self.size.height;
    
    return CGRectMake(x, y, w, h);
}
- (void)fire{
    CGSize bulletSize = self.bulletNormalSize;
    if (self.isEnhancedBullet){
        bulletSize = self.bulletEnhancedSize;
    }
    
    CGFloat y = self.position.y - self.size.height / 2 - bulletSize.height / 2;
    CGFloat x = self.position.x;
    
    
    
    for (NSInteger i = 0; i < kFireCount; i++){
        CGPoint p = CGPointMake(x, y - i * bulletSize.height * 2);
        Bullet *b = [Bullet bulletWithPosition:p isEnhanced:self.isEnhancedBullet];
        [self.bulletSet addObject:b];
    }
    //NSLog(@"fire: %d",self.bulletSet.count);
}
@end
