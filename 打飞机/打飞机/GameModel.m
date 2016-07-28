//
//  GameModel.m
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

+ (id)gameModelWithArea:(CGRect)gameArea heroSize:(CGSize)heroSize{
    GameModel *m = [[GameModel alloc]init];
    
    m.gameArea = gameArea;
    
    m.bgFrame1 = gameArea;
    m.bgFrame2 = CGRectOffset(gameArea, 0, -gameArea.size.height);
    
    m.hero = [Hero heroWithSize:heroSize gameArea:gameArea];
    
    m.score = 0;
    
    return m;
}

- (Enemy *)createEnemyWithType:(EnemyType)type size:(CGSize)size{
    return [Enemy enemyWithType:type size:size gameArea:self.gameArea];
}

- (void)bgMoveDown{
    self.bgFrame1 = CGRectOffset(self.bgFrame1, 0, 1);
    self.bgFrame2 = CGRectOffset(self.bgFrame2, 0, 1);
    
    CGRect topFrame = CGRectOffset(self.gameArea, 0, -self.gameArea.size.height);
    if (self.bgFrame1.origin.y >= self.gameArea.size.height){
        self.bgFrame1 = topFrame;
    }
    if (self.bgFrame2.origin.y >= self.gameArea.size.height){
        self.bgFrame2 = topFrame;
    }
}

@end
