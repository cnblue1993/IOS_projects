//
//  Bullet.h
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Bullet : NSObject

@property (assign, nonatomic) CGPoint position;
@property (assign, nonatomic) NSInteger damage;
@property (assign, nonatomic) BOOL isEnhanced;
@property (assign, nonatomic) BOOL isUsed;

+ (id)bulletWithPosition:(CGPoint)position isEnhanced:(BOOL)isEnhanced;

@end
