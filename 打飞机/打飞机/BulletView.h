//
//  BulletView.h
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bullet.h"

@interface BulletView : UIImageView

@property (strong, nonatomic) Bullet *bullet;

- (id)initWithImage:(UIImage *)image bullet:(Bullet *)bullet;
@end
