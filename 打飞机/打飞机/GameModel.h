//
//  GameModel.h
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Hero.h"
#import "Enemy.h"

@interface GameModel : NSObject

@property (assign, nonatomic) CGRect gameArea;

@property (assign, nonatomic) CGRect bgFrame1;
@property (assign, nonatomic) CGRect bgFrame2;

@property (assign, nonatomic) NSInteger score;

@property (strong, nonatomic) Hero *hero;

- (Enemy *)createEnemyWithType:(EnemyType)type size:(CGSize)size;

+ (id)gameModelWithArea:(CGRect)gameArea heroSize:(CGSize)heroSize;

- (void)bgMoveDown;
@end
