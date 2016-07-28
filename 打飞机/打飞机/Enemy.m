//
//  Enemy.m
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

+ (id)enemyWithType:(EnemyType)type size:(CGSize)size gameArea:(CGRect)gameArea{
    Enemy *e = [[Enemy alloc]init];
    
    e.type = type;
    
    CGFloat x = arc4random_uniform(gameArea.size.width - size.width) + size.width / 2.0;
    CGFloat y = -size.height / 2.0;
    e.position = CGPointMake(x, y);
    
    switch (type) {
        case kEnemySmall:
            e.hp = 1;
            e.speed = arc4random_uniform(4) + 2;
            e.score = 1;
            break;
            
        case kEnemyMiddle:
            e.hp = 10;
            e.speed = arc4random_uniform(3) + 2;
            e.score = 10;
            break;
            
        case kEnemyBig:
            e.hp = 50;
            e.speed = arc4random_uniform(2) + 2;
            e.score = 30;
            break;
    }
    e.blowupFrames = 0;
    e.toBlowup = NO;
    
    return e;
}
@end
