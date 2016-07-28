//
//  Bullet.m
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "Bullet.h"

#define kDamageNormal 1
#define kDamageEnhanced 2

@implementation Bullet

+ (id)bulletWithPosition:(CGPoint)position isEnhanced:(BOOL)isEnhanced{
    Bullet *b = [[Bullet alloc]init];
    
    b.position = position;
    b.isEnhanced = isEnhanced;
    b.damage = isEnhanced ? kDamageEnhanced : kDamageNormal;
    b.isUsed = NO;
    return b;
}
@end
