//
//  EnemyView.h
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enemy.h"
#import "ImageResources.h"

@interface EnemyView : UIImageView

@property (strong, nonatomic) NSArray *blowupImages;
@property (strong, nonatomic) UIImage *hitImage;
@property (strong, nonatomic) Enemy *enemy;

- (id)initWithEnemy:(Enemy *)enemy imageRes:(ImageResources *)imageRes;

@end
