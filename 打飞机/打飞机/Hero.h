//
//  Hero.h
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Hero : NSObject

@property (assign, nonatomic) CGPoint position;
@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic, readonly) CGRect collisionFrame;

@property (assign, nonatomic) NSInteger bombCount;
@property (assign, nonatomic) BOOL isEnhancedBullet;
@property (assign, nonatomic) NSInteger enhancedTime;

@property (assign, nonatomic) CGSize bulletNormalSize;
@property (assign, nonatomic) CGSize bulletEnhancedSize;

@property (strong, nonatomic) NSMutableSet *bulletSet;

+ (id)heroWithSize:(CGSize)size gameArea:(CGRect)gameArea;

- (void)fire;

@end
