//
//  EnemyView.m
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "EnemyView.h"

@implementation EnemyView

- (id)initWithEnemy:(Enemy *)enemy imageRes:(ImageResources *)imageRes{
    self = [super init];
    
    if (self){
        self.enemy = enemy;
        
        switch (enemy.type) {
            case kEnemySmall:
                self.image = imageRes.enemySmallImage;
                self.blowupImages = imageRes.enemySmallBlowupImages;
                break;
            
            case kEnemyMiddle:
                self.image = imageRes.enemyMiddleImage;
                self.blowupImages = imageRes.enemyMiddleBlowupImages;
                self.hitImage = imageRes.enemyMiddleHitImage;
                break;
                
            case kEnemyBig:
                self.image = imageRes.enemyBigImage[0];
                self.animationImages = imageRes.enemyBigImage;
                self.animationDuration = 0.5f;
                [self startAnimating];
                self.blowupImages = imageRes.enemyBigBlowupImages;
                self.hitImage = imageRes.enemyBigHitImage;
        }
        
        [self setFrame:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];
        [self setCenter:enemy.position];
    }
    
    return self;
}
@end
