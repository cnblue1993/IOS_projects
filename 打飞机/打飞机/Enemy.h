//
//  Enemy.h
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    kEnemySmall = 0,
    kEnemyMiddle,
    kEnemyBig,
} EnemyType;

@interface Enemy : NSObject

@property (assign, nonatomic) EnemyType type;
@property (assign, nonatomic) CGPoint position;
@property (assign, nonatomic) NSInteger hp;
@property (assign, nonatomic) NSInteger speed;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) BOOL toBlowup;
@property (assign, nonatomic) NSInteger blowupFrames;

+ (id)enemyWithType:(EnemyType)type size:(CGSize)size gameArea:(CGRect)gameArea;

@end
