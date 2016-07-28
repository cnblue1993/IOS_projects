//
//  ImageResources.h
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageResources : NSObject
//背景图片
@property (strong, nonatomic) UIImage *bgImage;

//战斗机相关图片
@property (strong, nonatomic) NSArray *heroFlyImages;
@property (strong, nonatomic) NSArray *heroBlowupImages;

//子弹相关图片
@property (strong, nonatomic) UIImage *bulletNormalImage;
@property (strong, nonatomic) UIImage *bulletEnhancedImage;

//敌机相关图片
@property (strong, nonatomic) UIImage *enemySmallImage;
@property (strong, nonatomic) NSArray *enemySmallBlowupImages;

@property (strong, nonatomic) UIImage *enemyMiddleImage;
@property (strong, nonatomic) NSArray *enemyMiddleBlowupImages;
@property (strong, nonatomic) UIImage *enemyMiddleHitImage;

@property (strong, nonatomic) NSArray *enemyBigImage;
@property (strong, nonatomic) NSArray *enemyBigBlowupImages;
@property (strong, nonatomic) UIImage *enemyBigHitImage;

@end
